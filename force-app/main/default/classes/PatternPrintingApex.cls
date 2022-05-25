/**
 *  Description     :  Pattern Printing Apex.                                                                                  
 *                     
 *  Created By      :  Pooja Hemrajani
 *
 *  Created Date    :  01-02-2022
 *
 *  Revision Logs   :  V1.0 - Created - Pooja Hemrajani
 *
 * 
 **/
public class PatternPrintingApex {

    /**
     *   
     *   @description    :   Pattern Printing Left triangle with star.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void patternPrintingLeftTriangle() {
        //Iterating over rows
        for(integer i=1;i<=5;i++) {
        	string pattern='  ';
            //Iterating over columns
        	for(integer j=1;j<=5;j++) {
            	if(j>=6-i ){
                	pattern = pattern + '*';
            	}
            	else{
                	pattern = pattern + '_';
            	}
        	}
        	system.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Downward Triangle Star Pattern Printing.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void downwardTriangleStarPatternPrinting() {
        //Iterating over rows
        for (integer i=0; i<5; i++) {
            String pattern = '';
            //Iterating over columns
            for (integer j=0; j<5-i; j++) {
                pattern = pattern + '*';
            }
        	System.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Number Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void numberPatternProgram () { 
        Integer index = 1;
        //Iterating over rows
        for (integer i=1; i<=5; i++) {
            String pattern = '';
            //Iterating over columns
            for (integer j=0; j<i; j++) {
                pattern = pattern + index;
                index = index + 1;
            }
        	System.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Descending Order Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void descendingOrderPatternProgram () { 
        //Iterating over rows
        for (integer i=4; i>=0; i--) {
            String pattern = '';
            //Iterating over columns
            for (integer j=5; j>i; j--) {
                pattern = pattern + j;
            }
        	System.debug(pattern);
        }
    }
    
	/**
     *   
     *   @description    :   Binary Number Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/    
    public static void binaryNumberPatternProgram () {
        Integer index = 1;
        //Iterating over rows
        for (integer i=0; i<5; i++) {
            String pattern = '';
            //Iterating over columns
            for (integer j=0; j<5; j++) {
                pattern = pattern + index;
                index = (index == 0 ? 1 :0);
            }
        	System.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Sandglass Star Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 02-02-2022 - Pooja Hemrajani
     * 
     **/    
    public static void sandglassStarPatternProgram () {
        integer k=0;
        //Iterating over rows
		for(integer i=1;i<=10;i++)
    	{
        	if(i<=5){
            	k++;
        	} 
        	else {
            	k--;
        	}
        	if(i==6){
            	k++;
        	} 
        	string pattern='  ';
            //Iterating over columns
        	for(integer j=1;j<=9;j++){
            	if(j>=k && j<=10-k){
                	pattern = pattern + '*';
            	}
            	else {
                	pattern = pattern + '_';
            	}
        	}
        	system.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Sandglass Numeric Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 02-02-2022 - Pooja Hemrajani
     * 
     **/    
    public static void sandglassNumericPatternProgram () {
        integer k=0;
        //Iterating over rows
		for(integer i=1;i<=10;i++)
    	{
        	if(i<=5){
            	k++;
        	} 
        	else {
            	k--;
        	}
        	if(i==6){
            	k++;
        	} 
        	string pattern='  ';
            //Iterating over columns
        	for(integer j=1;j<=9;j++){
            	if(j>=k && j<=10-k){
                	pattern = pattern + j;
            	}
            	else {
                	pattern = pattern + '_';
            	}
        	}
        	system.debug(pattern);
        }
    }
    
    /**
     *   
     *   @description    :   Numeric Diamond Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 02-02-2022 - Pooja Hemrajani
     * 
     **/    
    public static void numericDiamondPatternProgram () {
        integer n=4;
        integer index=4;
        //Iterating over rows
		for(integer i=0;i<(2*n-1);i++) {
            integer k=n;
            string pattern='  ';
            for(integer j=0;j<(2*n-1);j++) {
                if (i<n) {
                	if (j>=(n-i-1) && j< n+i) {
                    	pattern = pattern + k;
                	}
                	else {
                    	pattern = pattern + '_';
                	}
                }
                else {
                    if (j <= (i-n) || j >= (2*n-index)) {
                        pattern = pattern + '_';
                    }
                    else {
                        pattern = pattern + k;
                    }
                }
                if (j >= n-1) {
                    k++;
                }
                else {
                    k--;
                }
            }

            if (i < n-1) {
            	index--;
            }
            else {
                index++;
            }
        }
    }
    
    /**
     *   
     *   @description    :   Pascal’s Triangle Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 02-02-2022 - Pooja Hemrajani
     * 
     **/    
    public static void pascalTriangleProgram () {
        integer n = 5;
        integer m = (2 * n) - 2;
        List<Integer> temp_list_one = new List<Integer>();
        List<Integer> temp_list_two = new List<Integer>();
        Integer countIf = 0;
		Integer countElse = 0;	
        //Iterating over rows
		for(integer i=0;i<n;i++) {
            string pattern='  ';
            for(integer j=0;j<m;j++) {
                pattern = pattern + '_'; 
            }
            m = m - 1;
            for(integer j=0;j<i+1;j++) {
                if (j==0 || j==i) {
                    pattern = pattern + '1';
                    temp_list_one.add(1);
            		countIf = countIf + 1;
                } 
                else {
                    pattern = pattern + (temp_list_two.get(countElse) + temp_list_two.get(countElse+1));
                    temp_list_one.add(temp_list_two.get(countElse) + temp_list_two.get(countElse+1));
                    countElse = countElse + 1;
                }
            }
            System.debug(pattern);
   			countElse = 0;
            temp_list_two.clear();
    		temp_list_two.addAll(temp_list_one);
            temp_list_one.clear();
        }
    }

	/**
     *   
     *   @description    :   Reversed Pyramid Star Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 02-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void reversedPyramidStarPatternProgram() {
        Integer n = 5;
        Integer countElse = 0;
        //Iterating over rows
        for(integer i=0;i<n;i++) {
        	string pattern='  ';
            //Iterating over columns
        	for(integer j=0;j<(2*n-1);j++) {
                if (j<i || j>=(2*n-i-1)) {
                    pattern = pattern + '_';
                }
                else {
                    pattern = pattern + (countElse == 0 ? '*' : '_');
                    countElse = (countElse == 0 ? 1 : 0);
                }
        	}
        	system.debug(pattern);
            countElse = 0;
        }
    }

    /**
     *   
     *   @description    :   Alphabet A Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void alphabetAPatternProgram() {
        integer k=2,t=2;
        boolean m = true;
        for(integer i=1;i<=6;i++){
            string pattern='  ';
            if(i==2){
                k--;
                t++;
            }
            for(integer j=1;j<=3;j++) {
                if((i==2||i>=4) && j==2){
                    m=false;
                } else {
                    m=true;
                }
                if(j>=k && j<=t && m ) {
                    pattern = pattern + '*';  
                }
                else {
                    pattern = pattern + '_';
                }
            }
            system.debug(pattern);
        }
    }

    /**
     *   
     *   @description    :   Left Triangle Pascal’s Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void leftTrianglePascalsProgram() {
        integer n = 5;
        integer k = n+1;
        for(integer i=1;i<=(2*n-1);i++) {
        if(i<=n){
            k--;
        } else{
            k++;
        }
        string pattern ='  ';
        for(integer j=1;j<=n;j++) {
            if(j>=k) {
                pattern = pattern + '*';
            }
            else {
                 pattern = pattern + '_';
            }
        }
        system.debug(pattern);
        }
    }
    
    
    /**
     *   
     *   @description    :   Down triangle Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void downTriangleProgram() {
        boolean b = true;
        for(integer i=1;i<=5;i++) {
            string pattern = '  ';
            for(integer j=1;j<=9;j++) {
                if(i>=2 && i<=4){
                    if(j>=1+i && j<=9-i){
                        b=false;
                    } else{
                        b=true;
                    }
                }else{
                    b=true;
                }
                if(j>=i && j<=10-i && b){
                    pattern = pattern + '*';
                }
                else{
                    pattern = pattern + '_';
                }
            }
           System.debug(pattern);
        }
    }

    /**
     *   
     *   @description    :   Triangle Star pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void triangleStarPatternProgram() {
        boolean b=true;
		for(integer i=1;i<=5;i++) {
        	string pattern='  ';
        	for(integer j=1;j<=9;j++) {
            	if(i>=2 && i<=4){
                    if(j>=7-i && j<=3+i){
                        b=false;
                   	}else {
                        b=true;
                    }
                } else{
                    b=true;
                }
	            if(j>=6-i && j<=4+i && b ) {
                	pattern = pattern + '*';
            	}
            	else {
                 pattern = pattern + '_';
	            }
    	    }
        	system.debug(pattern);
        }
    }

    /**
     *   
     *   @description    :   Diamond Star Pattern Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void diamondStarPatternProgram() {
        integer k=6, t=4, s=6, v=4;
		boolean b=true;
		for(integer i=1;i<=9;i++) {
        	string pattern='  ';
	        if(i<=s){
                k--;
                t++;
            }else{
                k++;
                t--;
            }
			if(i>=2 && i<=8) {
                if(i<=s) {
                    s--;
                    v++;
                } else{
                    s++;
                    v--;
                }
            }
            for(integer j=1;j<=9;j++) {
            	if(j>=s && j<=v){
                    b=false;
                } else {
                    b=true;
                }
                if(j>=k && j<=t && b){
                	pattern = pattern + '*';
	            }
    	        else {
                 pattern = pattern + '_';
	            }
    	    }
        	system.debug(pattern);
        }
    }

    /**
     *   
     *   @description    :   Pyramid Patterns Program.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 04-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void pyramidPatternsProgram() {
        for(integer i=0;i<=4;i++){
        	string pattern = '  ';
        	for(integer j=0;j<=8;j++) {
	            if(j>=4-i && j<=4+i ) {
                	pattern = pattern + '*';
                }
            	else {
                 	pattern = pattern + '_';
            	}
        	}
	        system.debug(pattern); 
        }
    }

    /**
     *   
     *   @description    :   Right Pascals Triangle.
     *
     *   @args           :   none
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.0 - Created  - 01-02-2022 - Pooja Hemrajani
     * 
     **/
    public static void rightPascalsTriangle () {
        //Iterating over rows
        for (integer i=1; i<=5; i++) {
            String pattern = '';
            //Iterating over columns
            for (integer j=0; j<i; j++) {
                pattern = pattern + '*';
            }
        	System.debug(pattern);
        }
        //Iterating over rows
        for (integer i=0; i<4; i++) {
            String pattern = '';
            //Iterating over columns
            for (integer j=0; j<4-i; j++) {
                pattern = pattern + '*';
            }
        	System.debug(pattern);
        }
    }
    
}