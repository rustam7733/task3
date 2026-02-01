using System.Numerics;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/rustamsubhanov41_gmail_com", (string x, string y) => {
    var num1 = BigInteger.Parse(x);
    var num2 = BigInteger.Parse(y);

    if (!BigInteger.TryParse(x, out var n1) || !BigInteger.TryParse(y, out var n2)) return "NaN";

    if (num1 < 0 || num2 < 0) return "NaN";

    static BigInteger GetCommonMultiple(BigInteger a, BigInteger b)
    {
        a = BigInteger.Abs(a);
        b = BigInteger.Abs(b);
        while (b != 0)
        {
            a %= b;
            (a, b) = (b, a);
        }
        return a;
    }
    BigInteger result = BigInteger.Abs(num1 * num2) / GetCommonMultiple(num1, num2);
    return result.ToString();
});

app.Run();
