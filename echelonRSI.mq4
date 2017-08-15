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
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDHKD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDSEK", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDTRY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDMXN", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDZAR", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURGBP", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURAUD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNZD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURTRY", tl[i] ); }
        // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURHKD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDNZD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCHF", tl[i] ); }
        // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDSGD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHFJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SGDJPY", tl[i] ); }
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

  if(RSI > 79) {
    SendNotification( msgRSI );
  }
  else if(RSI < 21) {
    SendNotification( msgRSI );
  }

  return(0);
}
