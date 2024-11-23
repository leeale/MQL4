//+------------------------------------------------------------------+
//| file_name.mq4.mq4
//| Copyright 2017, Author Name
//| Link
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Author Name"
#property link "Link"
#property version "1.00"
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    int handle_ma;

    EventSetTimer(60);
    ChartSetInteger(0, CHART_SHOW_GRID, false);      // Sembunyikan grid
    ChartSetInteger(0, CHART_SHOW_VOLUMES, true);    // Tampilkan volume
    ChartSetInteger(0, CHART_MODE, CHART_CANDLES);   // Mode candlestick
    ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, true); // Tampilkan separator periode
    handle_ma = (int)iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 0);
    if (handle_ma == INVALID_HANDLE)
    {
        Print("Error inisialisasi MA");
        return INIT_FAILED;
    }

    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    EventKillTimer();
}

//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
{
    Print("Timer terpanggil pada: ", TimeToStr(TimeCurrent()));
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    // Cek apakah event adalah klik mouse
    if (id == CHARTEVENT_CLICK)
    {
        // Tampilkan koordinat klik
        Print("Koordinat klik - X: ", lparam, " Y: ", dparam);
    }
}

//+------------------------------------------------------------------+