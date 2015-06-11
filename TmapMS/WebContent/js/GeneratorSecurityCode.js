/**
 * 보안코드 생성
 */
var WordMin=16;//최소 문자 
var WordLength=16;//최대문자 

AnsiArray=new Array();
AnsiRoom=new Array();
AscCharNum=new Array();

AnsiArray[0]=[48,57]; //asc 숫자코드 범위 
AnsiArray[1]=[65,90];//알파벳 대문자 범위 
AnsiArray[2]=[97,122];//알파벳 소문자 범위 

function AnsiChar(){
	var Start=0,End=1,cnt=0;
	for(i=0;i<AnsiArray.length;i++) {
		for(j=AnsiArray[i][Start];j<AnsiArray[i][End];j++){
			AnsiRoom[cnt] = j;
			cnt++;
		}
	}
} 

function MakeCharNum(){
	AscCharNum = AnsiRoom;
	AscNum = parseInt(Math.random()*AscCharNum.length);
	return AscNum; 
}

function rnd(){
	WordRangr = parseInt(Math.random()*WordLength);
	if (WordRangr=WordMin){return WordRangr;}
	else{return rnd();} 
} 

function MakeWord(){
	AnsiChar();
	MakeCharNum();
		
	var Word="";
	var Len=rnd();
	for(i=0;i<Len;i++){
		Word+=String.fromCharCode(AnsiRoom[MakeCharNum()]);
	}
	return Word; 
}
