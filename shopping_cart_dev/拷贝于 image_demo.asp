<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script src="/scripts/shopeffects.js" type="text/javascript"></script>
<style type="text/css">
.PImageZoom
{
	
}


#PZImage
{
	left:0px;
	top:0px;
	position:absolute;
	z-index:29;
}

#PZI
{
	left:0px;
	top:0px;
	position:absolute;
	z-index:30;
	width:62px;
	height:70px;
	overflow:hidden;
}

#ZDiv
{
	width:230px;
	height:290px;
	overflow:hidden;
	position:absolute;
	top:0px;
	left:0px;
	z-index:100;
	border:solid 1px #666666;
}
#ZImage
{
	left:0px;
	top:0px;
	position:absolute;
	z-index:99;
}
.PBGImg
{
	background-color:#ffffff;
	z-index:2;
	position:absolute;
}
.PMainImage
{
	z-index:1;
	
}
#RollInstruction
{
	text-align:left;
	float:left;
}
#ThumbnailDiv
{
	clear:both;
	text-align:left;
	float:left;
}
</style>
</head>

<body>
            <div class="ProductImageLarge">
              <div>
                <div id="PZI" class="PImageWindow" onMouseOut="rZoom(event)" style="display:none;" >
                	<img id="PZImage" style="left:0px;top:0px;" />
                </div>
                <div  id="PZC" class="PBGImg"><img id="PHDImg" src="/images/x.gif" /></div>
                <div id="PZO" class="PMainImage"><img id="ctl07_MainImage" onMouseOver="sZoom(event)" SetWidth="250" SetHeight="400" src="1.jpg" style="border-width:0px;" /></div>
                <div id="ZDiv" style="display:none;background-color:#ffffff;">
                	<div id="ZLoad" style="position:relative;z-index:1000;top:0px;left:0px;display:none;background-color:#ffffff;">		
                    	<span class="ContentTextHeading"></span>
                        Loading....
                    </div>
                    <img id="ZImage"/>
                 </div>
                  <div id="RollInstruction">roll on image for zoom</div>
              </div>
            </div>
</body>
</html>
