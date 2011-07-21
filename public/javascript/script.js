/* The slide images are contained in the slides array. */
var slides = new Array('img/slide_1.jpg',
					   'img/slide_2.jpg',
					   'img/slide_3.jpg',
					   'img/slide_4.jpg',
					   'img/slide_5.jpg');

$(document).ready(function(){
	/* This code is executed after the DOM has been completely loaded */

	$('.arrow.left').click(function(){
		prev();

		/* Clearing the autoadvance if we click one of the arrows */
		clearInterval(auto);
	});

	$('.arrow.right').click(function(){
		next();
		clearInterval(auto);
	});

	/* Preloading all the slide images: */

	for(var i=0;i<slides.length;i++)
	{
		(new Image()).src=slides[i];
	}

	/* Showing the first one on page load: */
	transition(1);

	/* Setting auto-advance every 10 seconds */

	var auto;

	auto=setInterval(function(){
		next();
	},10*1000);
});
var current = {};
function transition(id)
{
	/* This function shows the slide specified by the id. */

	if(!slides[id-1]) return false;

	if(current.id)
	{
		/* If the slide we want to show is currently shown: */
		if(current.id == id) return false;

		/* Moving the current slide layer to the top: */
		current.layer.css('z-index',10);

		/* Removing all other slide layers that are positioned below */
		$('.mosaic-slide').not(current.layer).remove();
	}

	/* Creating a new slide and filling it with generateGrid: */
	var newLayer = $('<div class="mosaic-slide">').html(generateGrid({rows:7,cols:8,image:slides[id-1]}));

	/* Moving it behind the current slide: */
	newLayer.css('z-index',1);

	$('#mosaic-slideshow').append(newLayer);

	if(current.layer)
	{
		/* Hiding each tile of the current slide, exposing the new slide: */
		$('.tile',current.layer).each(function(i){
			var tile = $(this);
			setTimeout(function(){
				tile.css('visibility','hidden');
			},i*10);
		})
	}

	/* Adding the current id and newLayer element to the current object: */
	current.id = id;
	current.layer = newLayer;
}
function next()
{
	if(current.id)
	{
		transition(current.id%slides.length+1);
	}
}

function prev()
{
	if(current.id)
	{
		transition((current.id+(slides.length-2))%slides.length+1);
	}

}

/* Width and height of the tiles in pixels: */
var tabwidth=60, tabheight=60;

function generateGrid(param)
{
	/* This function generates the tile grid, with each tile containing a part of the slide image */

	/* Creating an empty jQuery object: */
	var elem = $([]),tmp;

	for(var i=0;i<param.rows;i++)
	{
		for(var j=0;j<param.cols;j++)
		{
			tmp = $('<div>', {
					"class":"tile",
					"css":{
						"background":'#555 url('+param.image+') no-repeat '+(-j*tabwidth)+'px '+(-i*tabheight)+'px'
					}
			});

			/* Adding the tile to the jQuery object: */
			elem = elem.add(tmp);
		}

		/* Adding a clearing element at the end of each line. This will clearly divide the divs into rows: */
		elem = elem.add('<div class="clear"></div>');
	}

	return elem;
}
