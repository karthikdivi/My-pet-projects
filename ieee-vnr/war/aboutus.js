/*
 * JS for aboutus generated by Appery.io
 */

Appery.getProjectGUID = function() {
    return '2edf0040-12df-4cb7-b475-63ca6b88e61c';
};

function navigateTo(outcome, useAjax) {
    Appery.navigateTo(outcome, useAjax);
}

// Deprecated


function adjustContentHeight() {
    Appery.adjustContentHeightWithPadding();
}

function adjustContentHeightWithPadding(_page) {
    Appery.adjustContentHeightWithPadding(_page);
}

function setDetailContent(pageUrl) {
    Appery.setDetailContent(pageUrl);
}

Appery.AppPages = [{
    "name": "EVENTS",
    "location": "EVENTS.html"
}, {
    "name": "startScreen",
    "location": "startScreen.html"
}, {
    "name": "aboutus",
    "location": "aboutus.html"
}];

aboutus_js = function(runBeforeShow) {

    /* Object & array with components "name-to-id" mapping */
    var n2id_buf = {
        'mobilenavbar_1': 'aboutus_mobilenavbar_1',
        'mobilenavbaritem_2': 'aboutus_mobilenavbaritem_2',
        'mobilenavbaritem_3': 'aboutus_mobilenavbaritem_3',
        'mobilenavbaritem_4': 'aboutus_mobilenavbaritem_4',
        'mobileimage_12': 'aboutus_mobileimage_12',
        'html_8': 'aboutus_html_8',
        'mobilelink_10': 'aboutus_mobilelink_10',
        'html_11': 'aboutus_html_11'
    };

    if ("n2id" in window && window.n2id !== undefined) {
        $.extend(n2id, n2id_buf);
    } else {
        window.n2id = n2id_buf;
    }

    if (navigator.userAgent.indexOf("IEMobile") != -1) {
        // Fixing issue https://github.com/jquery/jquery-mobile/issues/5424 on Windows Phone
        $("div[data-role=footer]").css("bottom", "-36px");
    }

    Appery.CurrentScreen = 'aboutus';

    /*
     * Nonvisual components
     */
    var datasources = [];

    /*
     * Events and handlers
     */

    // Before Show
    var aboutus_beforeshow = function() {
            Appery.CurrentScreen = "aboutus";
            for (var idx = 0; idx < datasources.length; idx++) {
                datasources[idx].__setupDisplay();
            }
        };

    // On Load
    var aboutus_onLoad = function() {
            aboutus_elementsExtraJS();

            // TODO fire device events only if necessary (with JS logic)
            aboutus_deviceEvents();
            aboutus_windowEvents();
            aboutus_elementsEvents();
        };

    // screen window events
    var aboutus_windowEvents = function() {

            $('#aboutus').bind('pageshow orientationchange', function() {
                var _page = this;
                adjustContentHeightWithPadding(_page);
            });

        };

    // device events
    var aboutus_deviceEvents = function() {
            document.addEventListener("deviceready", function() {

            });
        };

    // screen elements extra js
    var aboutus_elementsExtraJS = function() {
            // screen (aboutus) extra code

        };

    // screen elements handler
    var aboutus_elementsEvents = function() {
            $(document).on("click", "a :input,a a,a fieldset label", function(event) {
                event.stopPropagation();
            });

            $(document).off("click", '#aboutus_mobileheader [name="mobilenavbaritem_2"]').on({
                click: function() {
                    if (!$(this).attr('disabled')) {
                        Appery.navigateTo('startScreen', {
                            transition: 'slide',
                            reverse: false
                        });

                    }
                },
            }, '#aboutus_mobileheader [name="mobilenavbaritem_2"]');
            $(document).off("click", '#aboutus_mobileheader [name="mobilenavbaritem_3"]').on({
                click: function() {
                    if (!$(this).attr('disabled')) {
                        Appery.navigateTo('EVENTS', {
                            transition: 'slide',
                            reverse: false
                        });

                    }
                },
            }, '#aboutus_mobileheader [name="mobilenavbaritem_3"]');

        };

    $(document).off("pagebeforeshow", "#aboutus").on("pagebeforeshow", "#aboutus", function(event, ui) {
        aboutus_beforeshow();
    });

    if (runBeforeShow) {
        aboutus_beforeshow();
    } else {
        aboutus_onLoad();
    }
};

$(document).off("pagecreate", "#aboutus").on("pagecreate", "#aboutus", function(event, ui) {
    Appery.processSelectMenu($(this));
    aboutus_js();
});