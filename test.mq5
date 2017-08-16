//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property version   "1.00"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1 };

//+------------------------------------------------------------------+
// 初期化関数
//+------------------------------------------------------------------+

int OnInit() {
  return(INIT_SUCCEEDED);
}

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */

void OnTick() {

  int i;
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDSEKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDNOKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCNHmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDMXNmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDZARmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDTRYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURGBPmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURAUDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNOKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURSEKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURZARmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURTRYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHFJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPAUDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GOLDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SILVERmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "JP225Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US30Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US100Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US500Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EU50Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUS200Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "UK100Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GER30Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "FRA40Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "HK50Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SWI20Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SPAIN35Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "IT40Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHI50Cash", tl[i] ); }
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  // RSI判定
  int RSI = (int)MathRound(iRSI(s, t, 13, PRICE_CLOSE));
  string msgRSI = (string)s + " : " + (string)t + "分のRSI : " + (string)RSI;

  SendNotification(msgRSI);

  return(0);
}

//+------------------------------------------------------------------+
// 終了処理関数
//+------------------------------------------------------------------+

void OnDeinit(const int reason) {

}
