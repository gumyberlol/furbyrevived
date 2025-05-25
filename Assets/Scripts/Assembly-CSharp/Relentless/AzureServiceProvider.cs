using System;
using System.Threading.Tasks;

namespace Relentless
{
	public class AzureServiceProvider<T>
	{
		// Dummy class to mimic the real response without any fields
		public class GameDataServerResponse
		{
		}

		// Dummy method to simulate an async data fetch that returns an empty response
		public async Task<GameDataServerResponse> GetGameDataAsync()
		{
			await Task.Delay(1); // simulate async delay
			return new GameDataServerResponse();
		}

		// Dummy method to simulate uploading data (does nothing)
		public async Task UploadGameDataAsync(T data)
		{
			await Task.Delay(1); // simulate async delay
		}

		// Dummy property or method for AbTests, if needed
		public static object AbTests => null;
	}
}
