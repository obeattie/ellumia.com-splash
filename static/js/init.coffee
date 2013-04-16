window.Ellumia = {
    init: {}
}

Ellumia.init['responsiveYouTube'] = (root=document.body) ->
    for iframe in $('iframe[src*="www.youtube.com"]:not([data-ellumia-responsive])', root)
        iframe = $(iframe)
        
        # Insert a wrapper
        wrapper = $('<div class="video-wrap"/>')
            .css({ 'padding-top': "#{ (iframe.height() / iframe.width()) * 100 }%" })
            .insertBefore(iframe)
        
        # Make sure we only do this once    
        iframe
            .attr('data-ellumia-responsive', '1')
            .appendTo(wrapper)

Ellumia.init['animations'] = (root=document.body) ->
    $(root).addClass('ready')

yepnope {
    # jQuery (Google CDN)
    load: ['http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js'],
    
    callback: -> $(window).load ->
        # Call the initialisers in alpha order
        keys = (key for key, cb of Ellumia.init).sort()
        (Ellumia.init[key]() for key in keys)
        return
}

# --- YouTube --- #
window.onYouTubeIframeAPIReady = ->
    Ellumia.VideoPlayer = new YT.Player('yt', {
        events: {
            onReady: ->
                shade = $('#video #thumb')
                shade
                    .children('a')
                        .attr('href', '#')
                        .end()
                    .click ->
                        shade.hide()
                        Ellumia.VideoPlayer.playVideo()
                        return false
        }
    })


yepnope {
    load: ['https://www.youtube.com/iframe_api']
}
