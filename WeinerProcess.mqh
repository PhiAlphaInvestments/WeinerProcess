//+------------------------------------------------------------------+
//|                                                WeinerProcess.mqh |
//|                                                 William Nicholas |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "William Nicholas"
#property link      "https://www.mql5.com"



class WeinerProcess{

      private:
         string m_Symbol;
         ENUM_TIMEFRAMES m_TF;
         int    m_BarCount;
         int    m_Shift;
         double m_Walk;
         void   Update();
         
         
      
      
      
      public:


         int Sgn(double Value);
         WeinerProcess(string symbol, ENUM_TIMEFRAMES TimeFrame, int Shift, int BarCount);
         double WeinerProcessValue();
         void Init( string symbol, ENUM_TIMEFRAMES TimeFrame, int Shift, int BarCount);
         
         
         
         






};


WeinerProcess::WeinerProcess(string symbol,ENUM_TIMEFRAMES TimeFrame,int Shift,int BarCount){


      Init(symbol,TimeFrame,Shift,BarCount);


}

void WeinerProcess::Init(string symbol,ENUM_TIMEFRAMES TimeFrame,int Shift,int BarCount){
   
     m_Symbol = symbol;
     m_TF  = TimeFrame;
     m_Shift = Shift;
     m_BarCount = BarCount;
     m_Walk  = 0;
     Update(); 
  

}


int WeinerProcess::Sgn(double Value){

   int Res;
   
   if( Value >0){
      Res =1;
   
   }
   else{
      
      Res =-1;
   
   }


   return Res;

}

void WeinerProcess::Update(void){


   m_Walk = 0;
   
   
   for( int i =1 ; i < m_BarCount; i++){
   
      m_Walk += Sgn(  iClose(m_Symbol,m_TF,i+m_Shift) - iClose(m_Symbol,m_TF,i+m_Shift-1   ));
   
   }


}


double WeinerProcess::WeinerProcessValue(void){

   return -1*m_Walk;


}