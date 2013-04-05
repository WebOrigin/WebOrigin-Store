<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>New Demo of Image-Zoom</title>
<script language="JavaScript">
<!--
//WebOrigin Image-Zoom Function 1.1 beta build Nov21,2008
//Works fine in Internet Explorer, Google Chrome and Mozilla Firefox)
//Something wrong in Opera
//by Leask Huang

var dshowW=250; //默认预览图宽度(可由小图的showW,showH动态指定)
var dshowH=400; //默认预览图高度
var bborder=0; //大图边框
var sborder=0; //小图边框
var vborder=2; //小预览图边框
var bigW,bigH,smallW,smallH,showW,showH,viewW,viewH;//大图,小图,预览窗,小预览窗
var nview,nflag,picstatus,tempo,abox,zoomX,zoomY;
//初始化
window.onload=function init(){
	isIE=window.event?1:0;
	picshow.style.borderWidth=bborder;
	picshow.style.width=dshowW;
	picshow.style.height=dshowH;
	bpic.style.display="";
	abox=document.body.getElementsByTagName("div"); //初始化所有小图
	for (n=0;n<abox.length;n++)
		if (abox[n].className=="picbox"){
			var o=abox[n];
			var view=getview(o);
			var img=getimg(o);
			view.style.borderWidth=vborder;
			o.style.borderWidth=sborder;
			o.style.width=img.width+sborder*2*isIE;
			o.style.height=img.height+sborder*2*isIE;
			o.setAttribute("pid",n); //小图标记,主键唯一
			if (o.getAttribute("show")=="show") loadpic(o);
			o.onmouseout=function (){nview.style.visibility="hidden";}
		}
}
//载入图片
function loadpic(o){ 
	var view=getview(o);
	var img=getimg(o);
	bpic.style.display="none";
	nview=view; //标记活动小预览窗
	nflag=o.getAttribute("pid"); //当前图片标记,用来判断切换图片
	//改变预览窗大小
	if (img.getAttribute("showW")!=null) showW=parseInt(img.getAttribute("showW"));
	else showW=dshowW;
	if (img.getAttribute("showH")!=null) showH=parseInt(img.getAttribute("showH"));
	else showH=dshowH;
	picshow.style.width=showW+isIE*bborder*2;
	picshow.style.height=showH+isIE*bborder*2;

	if (img.getAttribute("dLeft")) bpic.style.marginLeft=-parseInt(img.getAttribute("dLeft"));
	if (img.getAttribute("dTop")) bpic.style.marginTop=-parseInt(img.getAttribute("dTop"));
	picstatus="loading";
	tempo=o;
	bpic.src=img.lowsrc;
}
//图片载入完成
function loaddone(o){
	bpic.style.display="block";
	var view=getview(o);
	var img=getimg(o);
	smallW=img.width; //改变小图,小预览窗大小
	smallH=img.height;
	bigW=bpic.width;
	bigH=bpic.height;
	if (showW>bigW){//如果预览图比大图大,则等于大图
		showW=bigW;
		picshow.style.width=showW+isIE*bborder*2;
	}
	if (showH>bigH){
		showH=bigH;
		picshow.style.height=showH+isIE*bborder*2;
	}
	zoomX=bigW/smallW;
	zoomY=bigH/smallH;
	viewW=showW*smallW/bigW;
	viewH=showH*smallH/bigH;
	nview.style.width=viewW-vborder*2*!isIE;
	nview.style.height=viewH-vborder*2*!isIE;
	nview.style.display="block"; 
	img.style.top=-nview.offsetHeight;
	if (!nview.style.left) nview.style.left=0;
	if (!nview.style.top) nview.style.top=0;
	picstatus="done"
}
//移动事件
function move(e,o,flag){ //flag,对象来源标记,FF下view的定位需要
	o=isIE?o.parentElement:o.parentNode;
	if (o.getAttribute("pid")!=nflag){ //判断是否切换了图片
		nview.style.visibility="hidden"; 
		loadpic(o); //载入新图片
	}
	if (picstatus="done"){ //如果大图载入完毕
		if (nview.style.visibility="hidden") nview.style.visibility="visible";
		var e=isIE?window.event:e;
		if (isIE==0){ //分别获取FF或IE的view位置
			if (flag==1){ //由于o的来源不同,使用不同的算法定位
				vX=e.layerX+parseInt(nview.style.left)-nview.offsetWidth/2-vborder;
				vY=e.layerY+parseInt(nview.style.top)-nview.offsetHeight/2-vborder;
			}else{
				vX=e.layerX-nview.offsetWidth/2-vborder;
				vY=e.layerY-nview.offsetHeight/2-vborder;
			}
		}
		else{
			vX=e.offsetX-nview.offsetWidth/2;
			vY=e.offsetY-nview.offsetHeight/2;
		} 
		if (vX < 0) vX = 0; //边界判断,不能超出缩略图的范围
		if (vY < 0) vY = 0;
		if (vX > smallW-viewW) {vX=smallW-viewW;mX=bigW-showW}else{mX=vX * zoomX;}
		if (vY > smallH-viewH) {vY=smallH-viewH;mY=bigH-showH}else{mY=vY * zoomY;}
		nview.style.left=vX;
		nview.style.top=vY;
		bpic.style.marginLeft = - mX; //刷新预览窗口
		bpic.style.marginTop = - mY;
	}
}
//得到view
function getview(o){
	var arr=o.getElementsByTagName("div");
	var n;
	for (n=0;n<arr.length;n++)
		if (arr[n].className="view") return arr[n];
}
//得到img
function getimg(o){
	var arr=o.getElementsByTagName("img");
	var n;
	for (n=0;n<arr.length;n++)
		if (arr[n].className="spic") return arr[n];
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
<style type="text/css">
<!--
*{padding:0;margin:0}
#picshow{border:0px;overflow:hidden;margin:0 auto}/*width,height随便定义,为了第一次显示时能看见loading*/
#bpic{display:none;visibility:hidden;}
.picbox{border:0px;overflow:hidden;float:left;width:0;height:0;text-align:left}/*注意:overflow:hidden;text-align:left不可更改,如果在IE的表格中定位会出问题*/
.spic{position:relative;}/*position:relative不可更改*/
.view{border:1px silver solid;z-index:100;font-size:1px;position:relative;visibility:hidden;display:none}/*position:relative;visibility:hidden;display:none不可更改*/
td{text-align:center;margin:0 auto}
//-->
</style>
</head>
<body>
WebOrigin Image-Zoom Function 1.1 beta build Nov21,2008<br>
Works fine in Internet Explorer, Google Chrome and Mozilla Firefox)<br>
!!!Something wrong in Opera!!!<br>
by Leask Huang<br><br>

<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><div class="picbox" onMouseMove="MM_showHideLayers('bpic','','show');" onMouseOut="MM_showHideLayers('bpic','','hide');" show="show">
      <!--设置show显示默认图片-->
      <div class="view" onMouseMove="MM_showHideLayers('bpic','','show');if (!isIE) move(event,this,1);" onMouseOut="MM_showHideLayers('bpic','','hide');"></div>
      <img src="1.jpg" lowsrc="2.jpg" class="spic" onMouseMove="MM_showHideLayers('bpic','','show');move(event,this,0);" onMouseOut="MM_showHideLayers('bpic','','hide');"/>
        </div>
    </td>
    <td width="250" align="center"><div id="picshow"> <img id="bpic" onload="loaddone(tempo)"/> </div></td>
  </tr>
</table>
</body>
</html>