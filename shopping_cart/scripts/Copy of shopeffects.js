// JavaScript Document

//PZC = div containing the greyed background
//PHDImg = grey background x image
//PZO = main image
//PZImage = new version of main image semi visible through div
//PZI = div porting pzimage

xs = "";
xe = "";
ys = "";
ye = "";
wmulti = "";
pzW = "";
pzH = "";
tOut = "";
mImage = "";
hImage = "";
function sZoom(e){
$("RollInstruction").innerHTML = "roll off image to exit zoom";
    obj = $(mImage)
    ow = obj.width;
    oh = obj.height;
    $("PZImage").src = obj.src;
    $("PZC").show();
    $("PZI").show(); 
    $("PHDImg").show(); 
    if(!($("ZImage").src == obj.src.replace("X=250&Y=400","X=1000&Y=1600&Quality=80"))){
    $("ZImage").observe('load',hideZLoad);
    $("ZImage").src = obj.src.replace("X=250&Y=400","X=1000&Y=1600&Quality=80");
    $("ZLoad").show();
    hImage = $("ZImage").src;
    }
    $("PZC").setOpacity(0.45);
    Effect.Appear("ZDiv", { duration: 0.2 })
    $("PZC").width = ow;
    $("PZC").height = oh;
    $("PHDImg").width = ow;
    $("PHDImg").height = oh;
    $("PZImage").width = ow;
    $("PZImage").height = oh;
    xs = $("PHDImg").cumulativeOffset()[0];
    xe = xs + ow;
    ys = $("PHDImg").cumulativeOffset()[1];
    ye = ys + oh;
    pzW = $("PZI").getWidth();
    pzH = $("PZI").getHeight();
    nleft = Event.pointerX(e)-(pzW/2);
    ntop = Event.pointerY(e)-(pzH/2);
	if(nleft < xs){
	nleft = xs
	}
	if(ntop < ys){
	ntop = ys;
	}
	nright = nleft + pzW;
	nbot = ntop + pzH;
	if(nright > xe){
	nleft = xe - pzW;
	}
	if(nbot > ye){
	ntop = ye - pzH;
	} 
    $("ZDiv").style.left = xe;
    $("ZDiv").style.top = ys;
    wmulti = $("ZImage").getWidth() / ow;
    bleft = ((nleft - xs) * wmulti);
    btop = ((ntop - ys) * wmulti);  	
 	$("PZI").style.left = nleft;
    $("PZImage").style.left = - (nleft)+xs;
    $("PZI").style.top = ntop;
    $("PZImage").style.top = - (ntop)+ys;
    $("ZImage").style.left = - bleft+xe;
    $("ZImage").style.top = - btop+ye;
    $("PHDImg").observe('mousemove',movebox);
	$("PZI").observe('mousemove',movebox);
	$("PZI").observe('mouseout',rZoom);
	tOut = setTimeout(rZoom,3000);
	}

function hideZLoad(){
$("ZLoad").hide();
}

function movebox(e){
if($("ZDiv").style.display=="none"){
$("ZDiv").show();
}
   	nleft = Event.pointerX(e)-(pzW/2);
	ntop = Event.pointerY(e)-(pzH/2);
	if(nleft < xs){
	nleft = xs
	}
	if(ntop < ys){
	ntop = ys;
	}
	nright = nleft + pzW;
	nbot = ntop + pzH;
	if(nright > xe){
	nleft = xe - pzW;
	}
	if(nbot > ye){
	ntop = ye - pzH;
	}
	if(wmulti <= 0){
	wmulti = $("ZImage").getWidth() / $("PHDImg").getWidth();
	}
    bleft = ((nleft - xs) * wmulti);
    btop = ((ntop - ys) * wmulti);
    $("PZI").style.left = nleft;
    $("PZImage").style.left = - (nleft)+xs;
    $("PZI").style.top = ntop;
    $("PZImage").style.top = - (ntop)+ys;
    $("ZImage").style.left = - bleft;
    $("ZImage").style.top = - btop;
    clearTimeout(tOut);
    tOut = setTimeout(rZoom,3000);
}


function rZoom(){
    clearTimeout(tOut);
    $("RollInstruction").innerHTML = "roll on image to zoom";
    $("PHDImg").stopObserving('mousemove',movebox)
    $("PZI").stopObserving('mousemove',movebox);
	$("PZI").stopObserving('mouseout',rZoom);
    $("PZC").hide();
    $("PZI").hide(); 
    $("PHDImg").hide(); 
    Effect.Fade("ZDiv", { duration: 0.2 })
}

function startZoom(objId){
mImage = objId;
$("ZImage").src = $(mImage).src.replace("X=250&Y=400","X=1000&Y=1600&Quality=80");
hImage = $("ZImage").src;
}