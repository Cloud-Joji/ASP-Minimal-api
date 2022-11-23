 using System.Diagnostics;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () => "Hello world! Try /api or /lol route");
app.MapGet("/api", () => "New api!!!");
app.MapGet("/lol", () => "LOL LMAO XD ROFL");

app.Run();


public class MiniApi
{
    static void Main() {
        Trace.WriteLine("Hello");
    }
}

