//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property version   "1.00"

/* ---------------------------------------
グローバル変数の宣言
---------------------------------------- */

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H2, PERIOD_H3, PERIOD_H4, PERIOD_H6, PERIOD_H8, PERIOD_H12, PERIOD_D1, PERIOD_W1 };

// 前処理（変数の宣言）
int handle = 0;
int buffer_num = 0;
int start_pos = 0;
int copy_count = 1;

double RSI_values[];
double RSI = 0;

/* ---------------------------------------
// 初期化関数
---------------------------------------- */

int OnInit() {
  return(INIT_SUCCEEDED);
}

/* ---------------------------------------
メイン関数：通貨と時間足を監視
---------------------------------------- */

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
  Sleep(180000);
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  // 工程1：RSI値の取得
  handle = iRSI(s, t, 13, PRICE_CLOSE);
  CopyBuffer(handle, buffer_num, start_pos, copy_count, RSI_values);
  RSI = NormalizeDouble(RSI_values[0], 1);

  string time;

  switch(t) {
    case 16385:
      time = "1時間";
      break;
    case 16386:
      time = "2時間";
      break;
    case 16387:
      time = "3時間";
      break;
    case 16388:
      time = "4時間";
      break;
    case 16390:
      time = "6時間";
      break;
    case 16392:
      time = "8時間";
      break;
    case 16396:
      time = "12時間";
      break;
    case 16408:
      time = "1日";
      break;
    case 32769:
      time = "1週間";
      break;
  }

  // RSI判定
  string strRSI = DoubleToString(RSI, 1);
  string joinMsg = s + " : " + time + "のRSI : " + strRSI;

  if(RSI <= 20) {
    if(RSI > 0) {
      SendNotification(joinMsg);
    }
  } else if(RSI >= 80) {
    SendNotification(joinMsg);
  }

  return(0);
}

/* ---------------------------------------
// 終了処理関数
---------------------------------------- */

void OnDeinit(const int reason) {

}
