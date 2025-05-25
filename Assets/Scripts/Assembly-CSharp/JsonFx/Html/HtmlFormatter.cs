using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using JsonFx.IO;
using JsonFx.Markup;
using JsonFx.Serialization;
using JsonFx.Utils;

namespace JsonFx.Html
{
	public class HtmlFormatter : ITextFormatter<MarkupTokenType>
	{
		public enum EmptyAttributeType
		{
			Html = 0,
			Xhtml = 1,
			Xml = 2
		}

		private const string ErrorUnexpectedToken = "Unexpected token ({0})";

		private readonly PrefixScopeChain ScopeChain = new PrefixScopeChain();

		private bool canonicalForm;

		private EmptyAttributeType emptyAttributes;

		private bool encodeNonAscii;

		public bool CanonicalForm
		{
			get
			{
				return canonicalForm;
			}
			set
			{
				canonicalForm = value;
			}
		}

		public EmptyAttributeType EmptyAttributes
		{
			get
			{
				return emptyAttributes;
			}
			set
			{
				emptyAttributes = value;
			}
		}

		public bool EncodeNonAscii
		{
			get
			{
				return encodeNonAscii;
			}
			set
			{
				encodeNonAscii = value;
			}
		}

		public HtmlFormatter(DataWriterSettings settings)
		{
			if (settings == null)
			{
				throw new ArgumentNullException("settings");
			}
		}

		public void ResetScopeChain()
		{
			ScopeChain.Clear();
		}

		public string Format(IEnumerable<Token<MarkupTokenType>> tokens)
		{
			using (StringWriter stringWriter = new StringWriter())
			{
				Format(tokens, stringWriter);
				return stringWriter.GetStringBuilder().ToString();
			}
		}

		public void Format(IEnumerable<Token<MarkupTokenType>> tokens, TextWriter writer)
		{
			if (tokens == null)
			{
				throw new ArgumentNullException("tokens");
			}
			IStream<Token<MarkupTokenType>> stream = Stream<Token<MarkupTokenType>>.Create(tokens);
			PrefixScopeChain.Scope scope = null;
			while (!stream.IsCompleted)
			{
				Token<MarkupTokenType> token = stream.Peek();
				switch (token.TokenType)
				{
				case MarkupTokenType.ElementBegin:
				case MarkupTokenType.ElementVoid:
				{
					DataName name = token.Name;
					MarkupTokenType tokenType = token.TokenType;
					stream.Pop();
					token = stream.Peek();
					scope = new PrefixScopeChain.Scope();
					if (ScopeChain.ContainsNamespace(name.NamespaceUri) || (string.IsNullOrEmpty(name.NamespaceUri) && !ScopeChain.ContainsPrefix(string.Empty)))
					{
						string prefix = ScopeChain.GetPrefix(name.NamespaceUri, false);
						scope.TagName = new DataName(name.LocalName, prefix, name.NamespaceUri);
					}
					else
					{
						scope[name.Prefix] = name.NamespaceUri;
						scope.TagName = name;
					}
					ScopeChain.Push(scope);
					IDictionary<DataName, Token<MarkupTokenType>> dictionary = null;
					while (!stream.IsCompleted && token.TokenType == MarkupTokenType.Attribute)
					{
						if (dictionary == null)
						{
							object dictionary3;
							if (canonicalForm)
							{
								IDictionary<DataName, Token<MarkupTokenType>> dictionary2 = new SortedList<DataName, Token<MarkupTokenType>>();
								dictionary3 = dictionary2;
							}
							else
							{
								dictionary3 = new Dictionary<DataName, Token<MarkupTokenType>>();
							}
							dictionary = (IDictionary<DataName, Token<MarkupTokenType>>)dictionary3;
						}
						DataName key = token.Name;
						string text = ScopeChain.EnsurePrefix(key.Prefix, key.NamespaceUri);
						if (text != null)
						{
							if (text != key.Prefix)
							{
								key = new DataName(key.LocalName, text, key.NamespaceUri, true);
							}
							if (!ScopeChain.ContainsNamespace(key.NamespaceUri) && (!string.IsNullOrEmpty(key.NamespaceUri) || ScopeChain.ContainsPrefix(string.Empty)))
							{
								scope[text] = key.NamespaceUri;
							}
						}
						stream.Pop();
						token = stream.Peek();
						dictionary[key] = token ?? MarkupGrammar.TokenNone;
						stream.Pop();
						token = stream.Peek();
					}
					WriteTag(writer, tokenType, name, dictionary, scope);
					scope = null;
					break;
				}
				case MarkupTokenType.ElementEnd:
					if (ScopeChain.HasScope)
					{
						WriteTag(writer, MarkupTokenType.ElementEnd, ScopeChain.Peek().TagName, null, null);
						ScopeChain.Pop();
					}
					stream.Pop();
					token = stream.Peek();
					break;
				case MarkupTokenType.Primitive:
				{
					ITextFormattable<MarkupTokenType> textFormattable = token.Value as ITextFormattable<MarkupTokenType>;
					if (textFormattable != null)
					{
						textFormattable.Format(this, writer);
					}
					else
					{
						HtmlEncode(writer, token.ValueAsString(), encodeNonAscii, canonicalForm);
					}
					stream.Pop();
					token = stream.Peek();
					break;
				}
				default:
					throw new TokenException<MarkupTokenType>(token, string.Format("Unexpected token ({0})", token.TokenType));
				}
			}
		}

		private void WriteTag(TextWriter writer, MarkupTokenType type, DataName tagName, IDictionary<DataName, Token<MarkupTokenType>> attributes, PrefixScopeChain.Scope prefixDeclarations)
		{
			if (string.IsNullOrEmpty(tagName.LocalName))
			{
				return;
			}
			string value = ScopeChain.EnsurePrefix(tagName.Prefix, tagName.NamespaceUri) ?? tagName.Prefix;
			writer.Write('<');
			if (type == MarkupTokenType.ElementEnd)
			{
				writer.Write('/');
			}
			if (!string.IsNullOrEmpty(value))
			{
				WriteLocalName(writer, value);
				writer.Write(':');
			}
			WriteLocalName(writer, tagName.LocalName);
			if (prefixDeclarations != null)
			{
				foreach (KeyValuePair<string, string> prefixDeclaration in prefixDeclarations)
				{
					WriteXmlns(writer, prefixDeclaration.Key, prefixDeclaration.Value);
				}
			}
			if (attributes != null)
			{
				foreach (KeyValuePair<DataName, Token<MarkupTokenType>> attribute in attributes)
				{
					string prefix = ScopeChain.EnsurePrefix(attribute.Key.Prefix, attribute.Key.NamespaceUri) ?? attribute.Key.Prefix;
					WriteAttribute(writer, prefix, attribute.Key.LocalName, attribute.Value);
				}
			}
			if (!canonicalForm && type == MarkupTokenType.ElementVoid)
			{
				writer.Write(' ');
				writer.Write('/');
			}
			writer.Write('>');
			if (canonicalForm && type == MarkupTokenType.ElementVoid)
			{
				WriteTag(writer, MarkupTokenType.ElementEnd, tagName, null, null);
			}
		}

		private void WriteXmlns(TextWriter writer, string prefix, string namespaceUri)
		{
			writer.Write(' ');
			WriteLocalName(writer, "xmlns");
			if (!string.IsNullOrEmpty(prefix))
			{
				writer.Write(':');
				WriteLocalName(writer, prefix);
			}
			writer.Write('=');
			writer.Write('"');
			HtmlAttributeEncode(writer, namespaceUri, encodeNonAscii, canonicalForm);
			writer.Write('"');
		}

		private void WriteAttribute(TextWriter writer, string prefix, string localName, Token<MarkupTokenType> value)
		{
			writer.Write(' ');
			if (!string.IsNullOrEmpty(prefix))
			{
				WriteLocalName(writer, prefix);
				writer.Write(':');
			}
			WriteLocalName(writer, localName);
			ITextFormattable<MarkupTokenType> textFormattable = value.Value as ITextFormattable<MarkupTokenType>;
			string value2 = ((textFormattable != null) ? null : value.ValueAsString());
			if (textFormattable == null && string.IsNullOrEmpty(value2))
			{
				switch (EmptyAttributes)
				{
				case EmptyAttributeType.Html:
					return;
				case EmptyAttributeType.Xhtml:
					value2 = localName;
					break;
				}
			}
			writer.Write('=');
			writer.Write('"');
			MarkupTokenType tokenType = value.TokenType;
			if (tokenType == MarkupTokenType.Primitive)
			{
				if (textFormattable != null)
				{
					textFormattable.Format(this, writer);
				}
				else
				{
					HtmlAttributeEncode(writer, value2, encodeNonAscii, canonicalForm);
				}
				writer.Write('"');
				return;
			}
			throw new TokenException<MarkupTokenType>(value, string.Format("Unexpected token ({0})", value));
		}

		private void WriteLocalName(TextWriter writer, string value)
		{
			int num = 0;
			int length = value.Length;
			for (int i = num; i < length; i++)
			{
				char c = value[i];
				if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
				{
					continue;
				}
				switch (c)
				{
				case '_':
				case 'À':
				case 'Á':
				case 'Â':
				case 'Ã':
				case 'Ä':
				case 'Å':
				case 'Æ':
				case 'Ç':
				case 'È':
				case 'É':
				case 'Ê':
				case 'Ë':
				case 'Ì':
				case 'Í':
				case 'Î':
				case 'Ï':
				case 'Ð':
				case 'Ñ':
				case 'Ò':
				case 'Ó':
				case 'Ô':
				case 'Õ':
				case 'Ö':
					continue;
				}
				if ((c < 'Ø' || c > 'ö') && (c < 'ø' || c > '\u02ff') && (c < 'Ͱ' || c > 'ͽ') && (c < 'Ϳ' || c > '\u1fff') && (c < '\u200c' || c > '\u200d') && (c < '⁰' || c > '\u218f') && (c < 'Ⰰ' || c > '\u2fef') && (c < '、' || c > '\ud7ff') && (c < '豈' || c > '﷏') && (c < 'ﷰ' || c > '\ufffd') && (i <= 0 || ((c < '0' || c > '9') && c != '-' && c != '.' && c != '·' && (c < '\u0300' || c > '\u036f') && (c < '\u203f' || c > '\u2040'))))
				{
					if (i > num)
					{
						writer.Write(value.Substring(num, i - num));
					}
					num = i + 1;
					writer.Write("_x");
					writer.Write(CharUtility.ConvertToUtf32(value, i).ToString("X4"));
					writer.Write("_");
				}
			}
			if (length > num)
			{
				writer.Write(value.Substring(num, length - num));
			}
		}

		public static void HtmlEncode(TextWriter writer, string value)
		{
			HtmlEncode(writer, value, false, false);
		}

		public static void HtmlEncode(TextWriter writer, string value, bool encodeNonAscii)
		{
			HtmlEncode(writer, value, encodeNonAscii, false);
		}

		private static void HtmlEncode(TextWriter writer, string value, bool encodeNonAscii, bool canonicalForm)
		{
			int num = 0;
			int length = value.Length;
			for (int i = num; i < length; i++)
			{
				char c = value[i];
				string value2;
				switch (c)
				{
				case '<':
					value2 = "&lt;";
					break;
				case '>':
					value2 = "&gt;";
					break;
				case '&':
					value2 = "&amp;";
					break;
				case '\r':
					if (!canonicalForm)
					{
						continue;
					}
					value2 = string.Empty;
					break;
				default:
					if ((c < ' ' && c != '\n' && c != '\t') || (encodeNonAscii && c >= '\u007f') || (c >= '\u007f' && c <= '\u0084') || (c >= '\u0086' && c <= '\u009f') || (c >= '\ufdd0' && c <= '\ufdef'))
					{
						value2 = "&#x" + CharUtility.ConvertToUtf32(value, i).ToString("X", CultureInfo.InvariantCulture) + ';';
						break;
					}
					continue;
				}
				if (i > num)
				{
					writer.Write(value.Substring(num, i - num));
				}
				num = i + 1;
				writer.Write(value2);
			}
			if (length > num)
			{
				writer.Write(value.Substring(num, length - num));
			}
		}

		public static void HtmlAttributeEncode(TextWriter writer, string value)
		{
			HtmlAttributeEncode(writer, value, false, false);
		}

		public static void HtmlAttributeEncode(TextWriter writer, string value, bool encodeNonAscii)
		{
			HtmlAttributeEncode(writer, value, encodeNonAscii, false);
		}

		private static void HtmlAttributeEncode(TextWriter writer, string value, bool encodeNonAscii, bool canonicalForm)
		{
			if (string.IsNullOrEmpty(value))
			{
				return;
			}
			int num = 0;
			int length = value.Length;
			for (int i = num; i < length; i++)
			{
				char c = value[i];
				string value2;
				switch (c)
				{
				case '<':
					value2 = "&lt;";
					break;
				case '>':
					if (canonicalForm)
					{
						continue;
					}
					value2 = "&gt;";
					break;
				case '&':
					value2 = "&amp;";
					break;
				case '"':
					value2 = "&quot;";
					break;
				case '\'':
					if (!canonicalForm)
					{
						continue;
					}
					value2 = "&apos;";
					break;
				default:
					if (c < ' ' || (encodeNonAscii && c >= '\u007f') || (c >= '\u007f' && c <= '\u0084') || (c >= '\u0086' && c <= '\u009f') || (c >= '\ufdd0' && c <= '\ufdef'))
					{
						value2 = "&#x" + CharUtility.ConvertToUtf32(value, i).ToString("X", CultureInfo.InvariantCulture) + ';';
						break;
					}
					continue;
				}
				if (i > num)
				{
					writer.Write(value.Substring(num, i - num));
				}
				num = i + 1;
				writer.Write(value2);
			}
			if (length > num)
			{
				writer.Write(value.Substring(num, length - num));
			}
		}
	}
}
