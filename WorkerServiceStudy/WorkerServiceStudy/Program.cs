using System.Diagnostics;
using WorkerServiceStudy;

using var processModule = System.Diagnostics.Process.GetCurrentProcess().MainModule;
Directory.SetCurrentDirectory(Path.GetDirectoryName(processModule?.FileName)!);

IHost host = Host.CreateDefaultBuilder(args)
    .UseWindowsService()
    .ConfigureServices(services =>
    {
        services.AddHostedService<Worker>();
    })
    .Build();

try
{
    await host.RunAsync();
}
catch (Exception e)
{
    File.AppendAllText("log.txt", e.Message);
    File.AppendAllText("log.txt", e.StackTrace);
}
