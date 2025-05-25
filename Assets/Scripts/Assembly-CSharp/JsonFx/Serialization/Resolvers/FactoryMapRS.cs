using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using JsonFx.CodeGen;
using Relentless;

namespace JsonFx.Serialization.Resolvers
{
	public sealed class FactoryMapRS
	{
		private const string ErrorCannotInstantiate = "Interfaces, Abstract classes, and unsupported ValueTypes cannot be instantiated. ({0})";

		private readonly IDictionary<Type, IFactoryHandler> CollectionCtors;

		public readonly IFactoryHandler Ctor;

		public readonly ParameterInfo[] CtorArgs;

		public readonly IProxyHandler Add;

		public readonly Type AddType;

		public readonly IProxyHandler AddRange;

		public readonly Type AddRangeType;

		public IEnumerable<Type> ArgTypes
		{
			get
			{
				if (CollectionCtors == null)
				{
					return Type.EmptyTypes;
				}
				return CollectionCtors.Keys;
			}
		}

		public IFactoryHandler this[Type argType]
		{
			get
			{
				IFactoryHandler value;
				if (CollectionCtors == null || !CollectionCtors.TryGetValue(argType, out value))
				{
					return null;
				}
				return value;
			}
		}

		public FactoryMapRS(Type type)
		{
			if (type == null)
			{
				throw new ArgumentNullException("type");
			}
			if (IsInvalidType(type))
			{
				throw new TypeLoadException(string.Format("Interfaces, Abstract classes, and unsupported ValueTypes cannot be instantiated. ({0})", type.FullName));
			}
			Ctor = DynamicMethodGeneratorRS.GetTypeFactory(type);
			ConstructorInfo[] constructors;
			if (!typeof(IEnumerable).IsAssignableFrom(type))
			{
				if (Ctor == null)
				{
					constructors = type.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.FlattenHierarchy);
					if (constructors.Length == 1)
					{
						ConstructorInfo constructorInfo = constructors[0];
						Ctor = DynamicMethodGeneratorRS.GetTypeFactory(constructorInfo);
						CtorArgs = constructorInfo.GetParameters();
					}
				}
				return;
			}
			constructors = type.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.FlattenHierarchy);
			CollectionCtors = new Dictionary<Type, IFactoryHandler>(constructors.Length);
			ConstructorInfo[] array = constructors;
			foreach (ConstructorInfo constructorInfo2 in array)
			{
				ParameterInfo[] parameters = constructorInfo2.GetParameters();
				if (parameters.Length == 1)
				{
					Type parameterType = parameters[0].ParameterType;
					if (parameterType != typeof(string) && (parameterType.GetInterface(TypeCoercionUtility.TypeGenericIEnumerable, false) != null || !typeof(IEnumerable).IsAssignableFrom(parameterType)))
					{
						CollectionCtors[parameterType] = DynamicMethodGeneratorRS.GetTypeFactory(constructorInfo2);
					}
				}
			}
			if (Ctor == null)
			{
				Ctor = DynamicMethodGeneratorRS.GetTypeFactory(type);
			}
			MethodInfo method = type.GetMethod("AddRange");
			if (method != null)
			{
				ParameterInfo[] parameters2 = method.GetParameters();
				if (parameters2.Length == 1)
				{
					AddRange = DynamicMethodGeneratorRS.GetMethodProxy(method);
					AddRangeType = parameters2[0].ParameterType;
				}
			}
			Type type2 = null;
			type2 = type.GetInterface(TypeCoercionUtility.TypeGenericICollection, false);
			method = ((type2 == null) ? type.GetMethod("Add") : type2.GetMethod("Add"));
			if (method != null)
			{
				ParameterInfo[] parameters3 = method.GetParameters();
				if (parameters3.Length == 1)
				{
					Add = DynamicMethodGeneratorRS.GetMethodProxy(method);
					AddType = parameters3[0].ParameterType;
				}
			}
		}

		internal static bool IsInvalidType(Type type)
		{
			return type.IsInterface || type.IsAbstract || type.IsValueType;
		}

		internal static bool IsImmutableType(Type type)
		{
			return !type.IsInterface && !type.IsAbstract && (type.IsValueType || type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy, null, Type.EmptyTypes, null) == null);
		}
	}
}
