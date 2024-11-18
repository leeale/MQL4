//+------------------------------------------------------------------+
//|                                                   SimpleEA.mq4   |
//|                        Copyright 2023, Your Name                 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Your Name"
#property link "https://www.mql5.com"
#property version "1.00"
#property strict

// Input parameters
input int FastMA = 10;
input int SlowMA = 20;
input double LotSize = 0.1;
input double StopLoss = 0;
input double TakeProfit = 0;
// Global variables
int ticket = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
  // Initialization code here
  return (INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
  // Deinitialization code here
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
  // Check if we already have an open position
  if (ticket > 0)
  {
    // Check if the position is still open
    if (OrderSelect(ticket, SELECT_BY_TICKET) && OrderCloseTime() == 0)
      return; // Exit if position is still open
    else
      ticket = 0; // Reset ticket if position is closed
  }

  // Calculate moving averages
  double fastMA = iMA(NULL, 0, FastMA, 0, MODE_SMA, PRICE_CLOSE, 0);
  double slowMA = iMA(NULL, 0, SlowMA, 0, MODE_SMA, PRICE_CLOSE, 0);
  double fastMAPrev = iMA(NULL, 0, FastMA, 0, MODE_SMA, PRICE_CLOSE, 1);
  double slowMAPrev = iMA(NULL, 0, SlowMA, 0, MODE_SMA, PRICE_CLOSE, 1);

  // Check for buy signal
  if (fastMAPrev <= slowMAPrev && fastMA > slowMA)
  {
    ticket = OrderSend(Symbol(), OP_BUY, LotSize, Ask, 3, 0, 0, "Buy Order", 0, 0, clrGreen);
    if (ticket < 0)
      Print("OrderSend failed with error #", GetLastError());
  }

  // Check for sell signal
  if (fastMAPrev >= slowMAPrev && fastMA < slowMA)
  {
    ticket = OrderSend(Symbol(), OP_SELL, LotSize, Bid, 3, 0, 0, "Sell Order", 0, 0, clrRed);
    if (ticket < 0)
      Print("OrderSend failed with error #", GetLastError());
  }
}

// tambahkan fungsi open order
int openOrder(int type, double lotSize, double stopLoss, double takeProfit)
{
  ticket = OrderSend(Symbol(), type, lotSize, Ask, 3, stopLoss, takeProfit, "Custom Order", 0, 0, clrGreen);
  if (ticket < 0)
    Print("OrderSend failed with error #", GetLastError());
  return ticket;
}

// tambahkan fungsi close order
void closeOrder(int ticket2)
{
  if (ticket > 0)
  {
    if (OrderSelect(ticket, SELECT_BY_TICKET) && OrderCloseTime() == 0)
    {
      double lotSize = OrderLots();
      double closePrice = OrderType() == OP_BUY ? Bid : Ask;
      bool result = OrderClose(ticket, lotSize, closePrice, 3, clrWhite);
      if (!result)
        Print("OrderClose failed with error #", GetLastError());
    }
    else
      Print("Position is not open");
  }
  else
    Print("Ticket is invalid");

  ticket = 0;
}

void order()
{
  return;
}
