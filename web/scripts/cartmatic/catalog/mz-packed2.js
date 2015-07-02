var MagicZoom_ua = 'msie';
var W = navigator.userAgent.toLowerCase();
if (W.indexOf("opera") != -1) {
    MagicZoom_ua = 'opera'
}
else 
    if (W.indexOf("msie") != -1) {
        MagicZoom_ua = 'msie'
    }
    else 
        if (W.indexOf("safari") != -1) {
            MagicZoom_ua = 'safari'
        }
        else 
            if (W.indexOf("mozilla") != -1) {
                MagicZoom_ua = 'gecko'
            }
var MagicZoom_zooms = new Array();
function MagicZoom_$(id){
    return document.getElementById(id)
};
function MagicZoom_getStyle(el, styleProp){
    if (el.currentStyle) {
        var y = el.currentStyle[styleProp];
        y = parseInt(y) ? y : '0px'
    }
    else 
        if (window.getComputedStyle) {
            var css = document.defaultView.getComputedStyle(el, null);
            var y = css ? css[styleProp] : null
        }
        else {
            y = el.style[styleProp];
            y = parseInt(y) ? y : '0px'
        }
    return y
};
function MagicZoom_getBounds(e){
    if (e.getBoundingClientRect) {
        var r = e.getBoundingClientRect();
        var wx = 0;
        var wy = 0;
        if (document.body && (document.body.scrollLeft || document.body.scrollTop)) {
            wy = document.body.scrollTop;
            wx = document.body.scrollLeft
        }
        else 
            if (document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) {
                wy = document.documentElement.scrollTop;
                wx = document.documentElement.scrollLeft
            }
        return {
            'left': r.left + wx,
            'top': r.top + wy,
            'right': r.right + wx,
            'bottom': r.bottom + wy
        }
    }
}

function MagicZoom_getEventBounds(e){
    var x = 0;
    var y = 0;
    if (MagicZoom_ua == 'msie') {
        y = e.clientY;
        x = e.clientX;
        if (document.body && (document.body.scrollLeft || document.body.scrollTop)) {
            y = e.clientY + document.body.scrollTop;
            x = e.clientX + document.body.scrollLeft
        }
        else 
            if (document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) {
                y = e.clientY + document.documentElement.scrollTop;
                x = e.clientX + document.documentElement.scrollLeft
            }
    }
    else {
        y = e.clientY;
        x = e.clientX;
        y += window.pageYOffset;
        x += window.pageXOffset
    }
    return {
        'x': x,
        'y': y
    }
}

function MagicView_ia(){
    return false
};
var MagicZoom_extendElement = function(){
    var args = arguments;
    if (!args[1]) 
        args = [this, args[0]];
    for (var property in args[1]) 
        args[0][property] = args[1][property];
    return args[0]
};
function MagicZoom_addEventListener(obj, event, listener){
    if (MagicZoom_ua == 'gecko' || MagicZoom_ua == 'opera' || MagicZoom_ua == 'safari') {
        try {
            obj.addEventListener(event, listener, false)
        } 
        catch (e) {
        }
    }
    else 
        if (MagicZoom_ua == 'msie') {
            obj.attachEvent("on" + event, listener)
        }
};
function MagicZoom_removeEventListener(obj, event, listener){
    if (MagicZoom_ua == 'gecko' || MagicZoom_ua == 'opera' || MagicZoom_ua == 'safari') {
        obj.removeEventListener(event, listener, false)
    }
    else 
        if (MagicZoom_ua == 'msie') {
            obj.detachEvent("on" + event, listener)
        }
};
function MagicZoom_concat(){
    var result = [];
    for (var i = 0; i < arguments.length; i++) 
        for (var j = 0; j < arguments[i].length; j++) 
            result.push(arguments[i][j]);
    return result
};
function MagicZoom_withoutFirst(sequence, skip){
    result = [];
    for (var i = skip; i < sequence.length; i++) 
        result.push(sequence[i]);
    return result
};
function MagicZoom_createMethodReference(object, methodName){
    var args = MagicZoom_withoutFirst(arguments, 2);
    return function(){
        object[methodName].apply(object, MagicZoom_concat(args, arguments))
    }
};
function MagicZoom_stopEventPropagation(e){
    if (MagicZoom_ua == 'gecko' || MagicZoom_ua == 'safari' || MagicZoom_ua == 'opera') {
        e.cancelBubble = true;
        e.preventDefault();
        e.stopPropagation()
    }
    else 
        if (MagicZoom_ua == 'msie') {
            window.event.cancelBubble = true
        }
};
function MagicZoom(smallImageContId, smallImageId, bigImageContId, bigImageId, settings,borderPadding){
    this.version = '2.2';
    this.recalculating = false;
    this.smallImageCont = MagicZoom_$(smallImageContId);
    this.smallImage = MagicZoom_$(smallImageId);
    this.bigImageCont = MagicZoom_$(bigImageContId);
    this.bigImage = MagicZoom_$(bigImageId);
	this.bigImageDiv = null;
	this.borderPadding=borderPadding;
    this.pup = 0;
    this.settings = settings;
    if (!this.settings["header"]) {
        this.settings["header"] = ""
    }
    this.bigImageSizeX = 0;
    this.bigImageSizeY = 0;
    this.smallImageSizeX = 0;
    this.smallImageSizeY = 0;
    this.popupSizeX = 20;
    this.popupSizey = 20;
    this.positionX = 0;
    this.positionY = 0;
    this.bigImageContStyleTop = '';
    this.loadingCont = null;
    if (this.settings["loadingImg"] != '') {
        this.loadingCont = document.createElement('DIV');
        this.loadingCont.style.position = 'absolute';
        this.loadingCont.style.visibility = 'hidden';
        this.loadingCont.className = 'MagicZoomLoading';
        this.loadingCont.style.display = 'block';
        this.loadingCont.style.textAlign = 'center';
        this.loadingCont.innerHTML = this.settings["loadingText"] + '<br/><img border="0" alt="' + this.settings["loadingText"] + '" src="' + this.settings["loadingImg"] + '"/>';
        this.smallImageCont.appendChild(this.loadingCont)
    }
    this.baseuri = '';
    this.safariOnLoadStarted = false;
    MagicZoom_zooms.push(this);
    this.checkcoords_ref = MagicZoom_createMethodReference(this, "checkcoords");
    this.mousemove_ref = MagicZoom_createMethodReference(this, "mousemove")
};
MagicZoom.prototype.stopZoom = function(){
    MagicZoom_removeEventListener(window.document, "mousemove", this.checkcoords_ref);
    MagicZoom_removeEventListener(this.smallImageCont, "mousemove", this.mousemove_ref);
    if (this.settings["position"] == "custom") {
        MagicZoom_$(this.smallImageCont.id + "-big").removeChild(this.bigImageCont)
    }
    else {
        this.smallImageCont.removeChild(this.bigImageCont)
    }
    this.smallImageCont.removeChild(this.pup)
};
MagicZoom.prototype.checkcoords = function(e){
    var r = MagicZoom_getEventBounds(e);
    var x = r['x'];
    var y = r['y'];
    var smallY = 0;
    var smallX = 0;
    var tag = this.smallImage;
    while (tag && tag.tagName != "BODY" && tag.tagName != "HTML") {
        smallY += tag.offsetTop;
        smallX += tag.offsetLeft;
        tag = tag.offsetParent
    } 
    if (MagicZoom_ua == 'msie') {
        var r = MagicZoom_getBounds(this.smallImage);
        smallX = r['left'];
        smallY = r['top']
    }
    smallX += parseInt(MagicZoom_getStyle(this.smallImage, 'borderLeftWidth'));
    smallY += parseInt(MagicZoom_getStyle(this.smallImage, 'borderTopWidth'));
    if (MagicZoom_ua != 'msie' || !(document.compatMode && 'backcompat' == document.compatMode.toLowerCase())) {
        smallX += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingLeft'));
        smallY += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingTop'))
    }
    if (x > parseInt(smallX + this.smallImageSizeX)) {
        this.hiderect();
        return false
    }
    if (x < parseInt(smallX)) {
        this.hiderect();
        return false
    }
    if (y > parseInt(smallY + this.smallImageSizeY)) {
        this.hiderect();
        return false
    }
    if (y < parseInt(smallY)) {
        this.hiderect();
        return false
    }
    if (MagicZoom_ua == 'msie') {
        this.smallImageCont.style.zIndex = 1
    }
    return true
};
MagicZoom.prototype.mousedown = function(e){
    MagicZoom_stopEventPropagation(e);
    this.smallImageCont.style.cursor = 'move'
};
MagicZoom.prototype.mouseup = function(e){
    MagicZoom_stopEventPropagation(e);
    this.smallImageCont.style.cursor = 'default'
};
MagicZoom.prototype.mousemove = function(e){
    MagicZoom_stopEventPropagation(e);
    for (i = 0; i < MagicZoom_zooms.length; i++) {
        if (MagicZoom_zooms[i] != this) {
            MagicZoom_zooms[i].checkcoords(e)
        }
    }
    if (this.settings && this.settings["drag_mode"] == true) {
        if (this.smallImageCont.style.cursor != 'move') {
            return
        }
    }
    if (this.recalculating) {
        return
    }
    if (!this.checkcoords(e)) {
        return
    }
    this.recalculating = true;
    var smallImg = this.smallImage;
    var smallX = 0;
    var smallY = 0;
    if (MagicZoom_ua == 'gecko' || MagicZoom_ua == 'opera' || MagicZoom_ua == 'safari') {
        var tag = smallImg;
        while (tag.tagName != "BODY" && tag.tagName != "HTML") {
            smallY += tag.offsetTop;
            smallX += tag.offsetLeft;
            tag = tag.offsetParent
        }
    }
    else {
        var r = MagicZoom_getBounds(this.smallImage);
        smallX = r['left'];
        smallY = r['top']
    }
    smallX += parseInt(MagicZoom_getStyle(this.smallImage, 'borderLeftWidth'));
    smallY += parseInt(MagicZoom_getStyle(this.smallImage, 'borderTopWidth'));
    if (MagicZoom_ua != 'msie' || !(document.compatMode && 'backcompat' == document.compatMode.toLowerCase())) {
        smallX += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingLeft'));
        smallY += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingTop'))
    }
    var r = MagicZoom_getEventBounds(e);
    var x = r['x'];
    var y = r['y'];
    this.positionX = x - smallX;
    this.positionY = y - smallY;
    if ((this.positionX + this.popupSizeX / 2) >= this.smallImageSizeX) {
        this.positionX = this.smallImageSizeX - this.popupSizeX / 2
    }
    if ((this.positionY + this.popupSizeY / 2) >= this.smallImageSizeY) {
        this.positionY = this.smallImageSizeY - this.popupSizeY / 2
    }
    if ((this.positionX - this.popupSizeX / 2) <= 0) {
        this.positionX = this.popupSizeX / 2
    }
    if ((this.positionY - this.popupSizeY / 2) <= 0) {
        this.positionY = this.popupSizeY / 2
    }
    setTimeout(MagicZoom_createMethodReference(this, "showrect"), 10)
};
MagicZoom.prototype.showrect = function(){
    var pleft = this.positionX - this.popupSizeX / 2;
    var ptop = this.positionY - this.popupSizeY / 2;
    var perX = pleft * (this.bigImageSizeX / this.smallImageSizeX);
    var perY = ptop * (this.bigImageSizeY / this.smallImageSizeY);
    if (document.documentElement.dir == 'rtl') {
        perX = (this.positionX + this.popupSizeX / 2 - this.smallImageSizeX) * (this.bigImageSizeX / this.smallImageSizeX)
    }
    pleft += parseInt(MagicZoom_getStyle(this.smallImage, 'borderLeftWidth'));
    ptop += parseInt(MagicZoom_getStyle(this.smallImage, 'borderTopWidth'));
    if (MagicZoom_ua != 'msie' || !(document.compatMode && 'backcompat' == document.compatMode.toLowerCase())) {
        pleft += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingLeft'));
        ptop += parseInt(MagicZoom_getStyle(this.smallImage, 'paddingTop'))
    }
    this.pup.style.left = pleft + 'px';
    this.pup.style.top = ptop + 'px';
    this.pup.style.visibility = "visible";
    if ((this.bigImageSizeX - perX) < parseInt(this.bigImageCont.style.width)) {
        perX = this.bigImageSizeX - parseInt(this.bigImageCont.style.width)
    }
    var headerH = 0;
    if (this.settings && this.settings["header"] != "") {
        var headerH = 19
    }
    if (this.bigImageSizeY > (parseInt(this.bigImageCont.style.height) - headerH)) {
        if ((this.bigImageSizeY - perY) < (parseInt(this.bigImageCont.style.height) - headerH)) {
            perY = this.bigImageSizeY - parseInt(this.bigImageCont.style.height) + headerH
        }
    }
	this.bigImageDiv.style.left = (-perX) + 'px';
    this.bigImageDiv.style.top = (-perY) + 'px';
    this.bigImageCont.style.top = this.bigImageContStyleTop;
    this.bigImageCont.style.display = 'block';
    this.bigImageCont.style.visibility = 'visible';
   // this.bigImage.style.display = 'block';
   // this.bigImage.style.visibility = 'visible';
    this.bigImageDiv.style.display = 'block';
    this.bigImageDiv.style.visibility = 'visible';
    this.recalculating = false
};
MagicZoom.prototype.hiderect = function(){
    if (this.settings && this.settings["bigImage_always_visible"] == true) 
        return;
    if (this.pup) {
        this.pup.style.visibility = "hidden"
    }
    this.bigImageCont.style.top = '-10000px';
    if (MagicZoom_ua == 'msie') {
        this.smallImageCont.style.zIndex = 0
    }
};
MagicZoom.prototype.recalculatePopupDimensions = function(){
    this.popupSizeX = parseInt(this.bigImageCont.style.width) / (this.bigImageSizeX / this.smallImageSizeX);
    if (this.settings && this.settings["header"] != "") {
        this.popupSizeY = (parseInt(this.bigImageCont.style.height) - 19) / (this.bigImageSizeY / this.smallImageSizeY)
    }
    else {
        this.popupSizeY = parseInt(this.bigImageCont.style.height) / (this.bigImageSizeY / this.smallImageSizeY)
    }
    if (this.popupSizeX > this.smallImageSizeX) {
        this.popupSizeX = this.smallImageSizeX
    }
    if (this.popupSizeY > this.smallImageSizeY) {
        this.popupSizeY = this.smallImageSizeY
    }
    this.popupSizeX = Math.round(this.popupSizeX);
    this.popupSizeY = Math.round(this.popupSizeY);
    if (!(document.compatMode && 'backcompat' == document.compatMode.toLowerCase())) {
        var bw = parseInt(MagicZoom_getStyle(this.pup, 'borderLeftWidth'));
        this.pup.style.width = (this.popupSizeX - 2 * bw) + 'px';
        this.pup.style.height = (this.popupSizeY - 2 * bw) + 'px'
    }
    else {
        this.pup.style.width = this.popupSizeX + 'px';
        this.pup.style.height = this.popupSizeY + 'px'
    }
};
MagicZoom.prototype.initPopup = function(){
    this.pup = document.createElement("DIV");
    this.pup.className = 'MagicZoomPup';
    this.pup.style.zIndex = 10;
    this.pup.style.visibility = 'hidden';
    this.pup.style.position = 'absolute';
    this.pup.style["opacity"] = parseFloat(this.settings['opacity'] / 100.0);
    this.pup.style["-moz-opacity"] = parseFloat(this.settings['opacity'] / 100.0);
    this.pup.style["-html-opacity"] = parseFloat(this.settings['opacity'] / 100.0);
    this.pup.style["filter"] = "alpha(Opacity=" + this.settings['opacity'] + ")";
    this.smallImageCont.appendChild(this.pup);
    this.recalculatePopupDimensions();
    this.smallImageCont.unselectable = "on";
    this.smallImageCont.style.MozUserSelect = "none";
    this.smallImageCont.onselectstart = MagicView_ia;
    this.smallImageCont.oncontextmenu = MagicView_ia
};
MagicZoom.prototype.initBigContainer = function(){
    var bigimgsrc = this.bigImage.src;
    if (this.bigImageSizeY < parseInt(this.bigImageCont.style.height)) {
        this.bigImageCont.style.height = this.bigImageSizeY + 'px';
        if (this.settings && this.settings["header"] != "") {
            this.bigImageCont.style.height = (19 + this.bigImageSizeY) + 'px'
        }
    }
    if (this.bigImageSizeX < parseInt(this.bigImageCont.style.width)) {
        this.bigImageCont.style.width = this.bigImageSizeX + 'px'
    }
    while (this.bigImageCont.firstChild) {
        this.bigImageCont.removeChild(this.bigImageCont.firstChild)
    }
    if (MagicZoom_ua == 'msie') {
        var f = document.createElement("IFRAME");
        f.style.left = '0px';
        f.style.top = '0px';
        f.style.position = 'absolute';
        f.src = "javascript:''";
        f.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';
        f.style.width = this.bigImageCont.style.width;
        f.style.height = this.bigImageCont.style.height;
        f.frameBorder = 0;
        this.bigImageCont.appendChild(f)
    }
    if (this.settings && this.settings["header"] != "") {
        var f = document.createElement("DIV");
        f.className = 'MagicZoomHeader';
        f.id = 'MagicZoomHeader' + this.bigImageCont.id;
        f.style.position = 'relative';
        f.style.zIndex = 10;
        f.style.left = '0px';
        f.style.top = '0px';
        f.style.padding = '3px';
        f.innerHTML = this.settings["header"];
        this.bigImageCont.appendChild(f)
    }
    var ar1 = document.createElement("DIV");
    ar1.style.overflow = "hidden";
    this.bigImageCont.appendChild(ar1);
    this.bigImage = document.createElement("IMG");
    this.bigImage.src = bigimgsrc;
    //this.bigImage.style.position = 'relative';
   // this.bigImage.style.borderWidth = '0px';
    //this.bigImage.style.padding = '0px';
   // this.bigImage.style.left = '0px';
    //this.bigImage.style.top = '0px';
	//this.bigImage.align='absmiddle';
    ar1.appendChild(this.bigImage);
	this.bigImageDiv=ar1;
	this.bigImageDiv.style.position = 'relative';
    this.bigImageDiv.style.borderWidth = '0px';
    this.bigImageDiv.style.padding = '0px';
    this.bigImageDiv.style.left = '0px';
    this.bigImageDiv.style.top = '0px';
    this.bigImageDiv.style.width =this.bigImageSizeX+ 'px';
    this.bigImageDiv.style.height = this.bigImageSizeY+'px';
	this.bigImageDiv.style.verticalAlign = 'middle';
    this.bigImageDiv.style.textAlign = 'center';
};
MagicZoom.prototype.initZoom = function(){
    if (this.loadingCont != null && !this.bigImage.complete && this.smallImage.width != 0 && this.smallImage.height != 0) {
        this.loadingCont.style.left = (parseInt(this.smallImage.width) / 2 - parseInt(this.loadingCont.offsetWidth) / 2) + 'px';
        this.loadingCont.style.top = (parseInt(this.smallImage.height) / 2 - parseInt(this.loadingCont.offsetHeight) / 2) + 'px';
        this.loadingCont.style.visibility = 'visible'
    }
    if (MagicZoom_ua == 'safari') {
        if (!this.safariOnLoadStarted) {
            //MagicZoom_addEventListener(this.bigImage, "load", MagicZoom_createMethodReference(this, "initZoom"));
			MagicZoom_addEventListener(this.bigImageDiv, "load", MagicZoom_createMethodReference(this, "initZoom"));
            this.safariOnLoadStarted = true;
            return
        }
    }
    else {
        if (!this.bigImage.complete || !this.smallImage.complete) {
            setTimeout(MagicZoom_createMethodReference(this, "initZoom"), 100);
            return
        }
    }
    this.bigImage.style.borderWidth = '0px';
    this.bigImage.style.padding = '0px';
	var hp=this.bigImage.height/this.smallImage.height;
	var wp=this.bigImage.width/this.smallImage.width;
	if(this.borderPadding&&wp!=hp){
		if(wp>hp){
			 this.bigImageSizeY = this.bigImage.height*(this.smallImage.height/(this.bigImage.height/wp));
			 this.bigImageSizeX = this.bigImage.width;
		}else{
			this.bigImageSizeY = this.bigImage.height;
			this.bigImageSizeX = this.bigImage.width*(this.smallImage.width/(this.bigImage.width/hp));
		}
	}else{
	    this.bigImageSizeX = this.bigImage.width;
	    this.bigImageSizeY = this.bigImage.height;
	}
    this.smallImageSizeX = this.smallImage.width;
    this.smallImageSizeY = this.smallImage.height;
    if (this.bigImageSizeX == 0 || this.bigImageSizeY == 0 || this.smallImageSizeX == 0 || this.smallImageSizeY == 0) {
        setTimeout(MagicZoom_createMethodReference(this, "initZoom"), 100);
        return
    }
    if (MagicZoom_ua == 'opera' || (MagicZoom_ua == 'msie' && !(document.compatMode && 'backcompat' == document.compatMode.toLowerCase()))) {
        this.smallImageSizeX -= parseInt(MagicZoom_getStyle(this.smallImage, 'paddingLeft'));
        this.smallImageSizeX -= parseInt(MagicZoom_getStyle(this.smallImage, 'paddingRight'));
        this.smallImageSizeY -= parseInt(MagicZoom_getStyle(this.smallImage, 'paddingTop'));
        this.smallImageSizeY -= parseInt(MagicZoom_getStyle(this.smallImage, 'paddingBottom'))
    }
    if (this.loadingCont != null) 
        this.loadingCont.style.visibility = 'hidden';
    this.smallImageCont.style.width = this.smallImage.width + 'px';
    this.bigImageCont.style.top = '-10000px';
    this.bigImageContStyleTop = '0px';
    var r = MagicZoom_getBounds(this.smallImage);
    if (!r) {
        this.bigImageCont.style.left = this.smallImageSizeX + parseInt(MagicZoom_getStyle(this.smallImage, 'borderLeftWidth')) + parseInt(MagicZoom_getStyle(this.smallImage, 'borderRightWidth')) + parseInt(MagicZoom_getStyle(this.smallImage, 'paddingLeft')) + parseInt(MagicZoom_getStyle(this.smallImage, 'paddingRight')) + 15 + 'px'
    }
    else {
        this.bigImageCont.style.left = (r['right'] - r['left'] + 15) + 'px'
    }
    switch (this.settings['position']) {
        case 'left':
            this.bigImageCont.style.left = '-' + (15 + parseInt(this.bigImageCont.style.width)) + 'px';
            break;
        case 'bottom':
            if (r) {
                this.bigImageContStyleTop = r['bottom'] - r['top'] + 15 + 'px'
            }
            else {
                this.bigImageContStyleTop = this.smallImage.height + 15 + 'px'
            }
            this.bigImageCont.style.left = '0px';
            break;
        case 'top':
            this.bigImageContStyleTop = '-' + (15 + parseInt(this.bigImageCont.style.height)) + 'px';
            this.bigImageCont.style.left = '0px';
            break;
        case 'custom':
            this.bigImageCont.style.left = '0px';
            this.bigImageContStyleTop = '0px';
            break;
        case 'inner':
            this.bigImageCont.style.left = '0px';
            this.bigImageContStyleTop = '0px';
            if (this.settings['zoomWidth'] == -1) {
                this.bigImageCont.style.width = this.smallImageSizeX + 'px'
            }
            if (this.settings['zoomHeight'] == -1) {
                this.bigImageCont.style.height = this.smallImageSizeY + 'px'
            }
            break
    }
    if (this.pup) {
        this.recalculatePopupDimensions();
        if (this.settings && (this.settings["drag_mode"] == true || this.settings["bigImage_always_visible"] == true)) {
            this.showrect()
        }
        return
    }
    this.initBigContainer();
    this.initPopup();
    MagicZoom_addEventListener(window.document, "mousemove", this.checkcoords_ref);
    MagicZoom_addEventListener(this.smallImageCont, "mousemove", this.mousemove_ref);
    if (this.settings && this.settings["drag_mode"] == true) {
        MagicZoom_addEventListener(this.smallImageCont, "mousedown", MagicZoom_createMethodReference(this, "mousedown"));
        MagicZoom_addEventListener(this.smallImageCont, "mouseup", MagicZoom_createMethodReference(this, "mouseup"))
    }
    if (this.settings && (this.settings["drag_mode"] == true || this.settings["bigImage_always_visible"] == true)) {
        this.positionX = this.smallImageSizeX / 2;
        this.positionY = this.smallImageSizeY / 2;
        this.showrect()
    }
};
MagicZoom.prototype.replaceZoom = function(ael, e){
    if (ael.href == this.bigImage.src) 
        return;
    var newBigImage = document.createElement("IMG");
    newBigImage.id = this.bigImage.id;
    newBigImage.src = ael.href;
    var p = this.bigImage.parentNode;
    p.replaceChild(newBigImage, this.bigImage);
    this.bigImage = newBigImage;
    this.bigImage.style.position = 'relative';
    this.smallImage.src = ael.rev;
    if (ael.title != '' && MagicZoom_$('MagicZoomHeader' + this.bigImageCont.id)) {
        MagicZoom_$('MagicZoomHeader' + this.bigImageCont.id).firstChild.data = ael.title
    }
    this.safariOnLoadStarted = false;
    this.initZoom();
    this.smallImageCont.href = ael.href;
    try {
        MagicThumb.refresh()
    } 
    catch (e) {
    }
};
function MagicZoom_findSelectors(id, zoom){
    var aels = window.document.getElementsByTagName("A");
    for (var i = 0; i < aels.length; i++) {
        if (aels[i].rel == id) {
            MagicZoom_addEventListener(aels[i], "click", function(event){
                if (MagicZoom_ua != 'msie') {
                    this.blur()
                }
                else {
                    window.focus()
                }
                MagicZoom_stopEventPropagation(event);
                return false
            });
            MagicZoom_addEventListener(aels[i], zoom.settings['thumb_change'], MagicZoom_createMethodReference(zoom, "replaceZoom", aels[i]));
            aels[i].style.outline = '0';
            aels[i].mzextend = MagicZoom_extendElement;
            aels[i].mzextend({
                zoom: zoom,
                selectThisZoom: function(){
                    this.zoom.replaceZoom(null, this)
                }
            });
            var img = document.createElement("IMG");
            img.src = aels[i].href;
            img.style.position = 'absolute';
            img.style.left = '-10000px';
            img.style.top = '-10000px';
            document.body.appendChild(img);
            img = document.createElement("IMG");
            img.src = aels[i].rev;
            img.style.position = 'absolute';
            img.style.left = '-10000px';
            img.style.top = '-10000px';
            document.body.appendChild(img)
        }
    }
};
function MagicZoom_stopZooms(){
    while (MagicZoom_zooms.length > 0) {
        var zoom = MagicZoom_zooms.pop();
        zoom.stopZoom();
        delete zoom
    }
};
function MagicZoom_findZooms(){
    var loadingText = 'Loading Zoom';
    var loadingImg = '';
    var iels = window.document.getElementsByTagName("IMG");
    for (var i = 0; i < iels.length; i++) {
        if (/MagicZoomLoading/.test(iels[i].className)) {
            if (iels[i].alt != '') 
                loadingText = iels[i].alt;
            loadingImg = iels[i].src;
            break
        }
    }
    var aels = window.document.getElementsByTagName("A");
    for (var i = 0; i < aels.length; i++) {
        if (/MagicZoom/.test(aels[i].className)) {
            while (aels[i].firstChild) {
                if (aels[i].firstChild.tagName != 'IMG') {
                    aels[i].removeChild(aels[i].firstChild)
                }
                else {
                    break
                }
            }
            if (aels[i].firstChild.tagName != 'IMG') 
                throw "Invalid MagicZoom invocation!";
            var rand = Math.round(Math.random() * 1000000);
            aels[i].style.position = "relative";
            aels[i].style.display = 'block';
            aels[i].style.outline = '0';
            aels[i].style.textDecoration = 'none';
            MagicZoom_addEventListener(aels[i], "click", function(event){
                if (MagicZoom_ua != 'msie') {
                    this.blur()
                }
                MagicZoom_stopEventPropagation(event);
                return false
            });
            if (aels[i].id == '') {
                aels[i].id = "sc" + rand
            }
            if (MagicZoom_ua == 'msie') {
                aels[i].style.zIndex = 0
            }
            var smallImg = aels[i].firstChild;
			if(!smallImg.id)
            	smallImg.id = "sim" + rand;
            var bigCont = document.createElement("DIV");
            bigCont.id = "bc" + rand;
            re = new RegExp(/opacity(\s+)?:(\s+)?(\d+)/i);
            matches = re.exec(aels[i].rel);
            var opacity = 50;
            if (matches) {
                opacity = parseInt(matches[3])
            }
            re = new RegExp(/thumb\-change(\s+)?:(\s+)?(click|mouseover)/i);
            matches = re.exec(aels[i].rel);
            var thumb_change = 'click';
            if (matches) {
                thumb_change = matches[3]
            }
            re = new RegExp(/zoom\-width(\s+)?:(\s+)?(\w+)/i);
            var zoomWidth = -1;
            matches = re.exec(aels[i].rel);
            bigCont.style.width = '300px';
            if (matches) {
                bigCont.style.width = matches[3];
                zoomWidth = matches[3]
            }
            re = new RegExp(/zoom\-height(\s+)?:(\s+)?(\w+)/i);
            var zoomHeight = -1;
            matches = re.exec(aels[i].rel);
            bigCont.style.height = '300px';
            if (matches) {
                bigCont.style.height = matches[3];
                zoomHeight = matches[3]
            }
            re = new RegExp(/zoom\-position(\s+)?:(\s+)?(\w+)/i);
            matches = re.exec(aels[i].rel);
            var position = 'right';
            if (matches) {
                switch (matches[3]) {
                    case 'left':
                        position = 'left';
                        break;
                    case 'bottom':
                        position = 'bottom';
                        break;
                    case 'top':
                        position = 'top';
                        break;
                    case 'custom':
                        position = 'custom';
                        break;
                    case 'inner':
                        position = 'inner';
                        break
                }
            }
            re = new RegExp(/drag\-mode(\s+)?:(\s+)?(true|false)/i);
            matches = re.exec(aels[i].rel);
            var drag_mode = false;
            if (matches) {
                if (matches[3] == 'true') 
                    drag_mode = true
            }
            re = new RegExp(/always\-show\-zoom(\s+)?:(\s+)?(true|false)/i);
            matches = re.exec(aels[i].rel);
            var bigImage_always_visible = false;
            if (matches) {
                if (matches[3] == 'true') 
                    bigImage_always_visible = true
            }
            bigCont.style.overflow = 'hidden';
            bigCont.className = "MagicZoomBigImageCont";
            bigCont.style.zIndex = 100;
            bigCont.style.visibility = 'hidden';
            if (position != 'custom') {
                bigCont.style.position = 'absolute'
            }
            else {
                bigCont.style.position = 'relative'
            }
            var bigImg = document.createElement("IMG");
            bigImg.id = "bim" + rand;
            bigImg.src = aels[i].href;
            bigCont.appendChild(bigImg);
            if (position != 'custom') {
                aels[i].appendChild(bigCont)
            }
            else {
                MagicZoom_$(aels[i].id + '-big').appendChild(bigCont)
            }
            var settings = {
                bigImage_always_visible: bigImage_always_visible,
                drag_mode: drag_mode,
                header: aels[i].title,
                opacity: opacity,
                thumb_change: thumb_change,
                position: position,
                loadingText: loadingText,
                loadingImg: loadingImg,
                zoomWidth: zoomWidth,
                zoomHeight: zoomHeight
            };
            if (position == 'inner') {
                aels[i].title = ''
            }
            var zoom = new MagicZoom(aels[i].id, smallImg.id, bigCont.id, 'bim' + rand, settings,true);
            aels[i].mzextend = MagicZoom_extendElement;
            aels[i].mzextend({
                zoom: zoom
            });
            zoom.initZoom();
            MagicZoom_findSelectors(aels[i].id, zoom)
        }
    }
};
if (MagicZoom_ua == 'msie') 
    try {
        document.execCommand("BackgroundImageCache", false, true)
    } 
    catch (e) {
    };
addOnload(MagicZoom_findZooms);
//MagicZoom_addEventListener(window, "load", MagicZoom_findZooms);