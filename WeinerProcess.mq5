//+------------------------------------------------------------------+
//|                                                WeinerProcess.mq5 |
//|                                                 William Nicholas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+


#property description "RandomWalk"
#property indicator_separate_window
#property  indicator_buffers 1
#property  indicator_plots  1
#property  indicator_type1 DRAW_LINE
#property  indicator_color1 clrMediumBlue
#property  indicator_style1  STYLE_SOLID


input int Walk = 20;
input int Shift = 0;


double WalkBuffer[];




int Sgn( double Value ){

   int Res;
   
   
   if ( Value >0 ){
   
      Res =1;
   
   }
   else{
   
      Res =-1;
   
   }

   
   return Res;
}



int OnInit()
  {
//--- indicator buffers mapping
   IndicatorSetInteger(INDICATOR_LEVELS,2);
   IndicatorSetDouble(INDICATOR_LEVELVALUE, 0, -1*MathSqrt(Walk));
   IndicatorSetDouble(INDICATOR_LEVELVALUE, 1, MathSqrt(Walk));
   IndicatorSetDouble(INDICATOR_MAXIMUM, 3*MathSqrt(Walk));
   IndicatorSetDouble(INDICATOR_MINIMUM, -1*3*MathSqrt(Walk));
   
   
   SetIndexBuffer(0,WalkBuffer);
   
   
   string short_name= StringFormat("RandomWalk(%d)",Walk);
   IndicatorSetString(INDICATOR_SHORTNAME,short_name);
   PlotIndexSetString(0,PLOT_LABEL,short_name);
   
   
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

      ArrayInitialize(WalkBuffer,0.0);
      
      for( int i = Walk ; i < rates_total ; i++){
      
         WalkBuffer[i] = WalkFunc(close,i,time,rates_total);
      
      }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+


double WalkFunc(const double &close[] , const int position , const datetime &time[], const int rates){




   double dev = 0.0;
   
   for( int i =1 ; i< Walk; i++){
   
      dev += Sgn(close[position -i] - close[position-i+1]);
   
   }

   return (-1*dev);


}