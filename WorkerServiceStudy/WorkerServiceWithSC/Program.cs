using System.Diagnostics;
using WorkerServiceWithSC;

var isService = !(Debugger.IsAttached || args.Contains("--console"));

using var processModule = System.Diagnostics.Process.GetCurrentProcess().MainModule;
Directory.SetCurrentDirectory(Path.GetDirectoryName(processModule?.FileName)!);

var builder = Host.CreateDefaultBuilder(args)
    .ConfigureServices(services =>
    {
        services.AddHostedService<Worker>();
    });

try
{
    if (isService)
    {
        await builder.RunAsServiceAsync();
    }
    else
    {
        await builder.RunConsoleAsync();
    }
}
catch (Exception e)
{
    File.AppendAllText("log.txt", e.Message);
    File.AppendAllText("log.txt", e.StackTrace);
}