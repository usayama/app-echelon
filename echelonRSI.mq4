//+------------------------------------------------------------------+
//|                                                      Echelon.mq4 |
//|                                                          usayama |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "usayama"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

extern int flexTime = 5;
int tl[] = { 60, 240, 1440, 10080 };

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */

int start() {

  /*【 バーのチェック 】*/
  static int barsOld = 0;
  int barsNew = iBars( NULL, flexTime );
  int barsCheck = barsNew - barsOld;

  int i;
  if( barsCheck == 1 ) {
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
  barsOld = barsNew;
  return(0);
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon( string s, int t ) {

  // RSI判定
  int RSI = MathRound(iRSI(s, t, 13, 0, 0));
  string msgRSI = StringConcatenate(s, "：", t, "分のRSI：", RSI);

  if(RSI >= 80) {
    SendNotification( msgRSI );
  } else if(RSI <= 20) {
    SendNotification( msgRSI );
  }

  return(0);
}
