$(window).on('load', function () {
    var $preloader = $('#page-preloader'),
        $spinner = $preloader.find('.spinner');
    $spinner.fadeOut();
    $preloader.fadeOut();
    var img_1 = $('#block-1').find('.img-1');
    var h1 = $('#block-1').find('.h1');
    var h2 = $('#block-1').find('.h2');
    var coming = $('#block-1').find('.coming');
    var buttons_block1 = $('#block-1').find('.buttons').find('img');
    var p_block1 = $('#block-1').find('p');
    var left_input = $('#block-1').find('.left-input');
    var right_input = $('#block-1').find('.right-input');
    setTimeout(function () {
        h1.addClass('h-anim');
        img_1.addClass('animate-img-1');
        setTimeout(function () {
            h2.css('opacity', 1);
        }, 500);
        setTimeout(function () {
            coming.css({'opacity': 1, 'transform': 'translateX(0)'});
        }, 2000);
        setTimeout(function () {
            buttons_block1.each(function (i) {
                var ths = $(this);
                setInterval(function () {
                    ths.addClass('h-anim');
                }, 150 * i)
            });
        }, 2500);
        setTimeout(function () {
            p_block1.css('opacity', 1);
        }, 1000);
        setTimeout(function () {
            left_input.addClass('left-input-anim');
            right_input.addClass('right-input-anim');
        }, 1500);
    }, 300);
})
$(function () {
    var hamburger = $("#my-icon");
    var blocker = $('.blocker');
    var mobmnu = {
        icon: $("#my-icon"),
        selector: $('.mobile-menu'),
        page: $('.page'),
        blocker: $('.blocker'),
        open: function () {
            var ths = this;
            ths.selector.css('display', 'block');
            ths.page.css('transform', 'translateX(-80%)');
            ths.blocker.addClass('blocker-z-index');
            setTimeout(function () {
                ths.blocker.addClass('blocker-active blocker-anim');
            }, 100);
            ths.icon.addClass('is-active');
        },
        close: function () {
            var ths = this;
            ths.blocker.removeClass('blocker-active blocker-anim');
            setTimeout(function () {
                ths.blocker.removeClass('blocker-z-index');
            }, 500)
            ths.page.css('transform', 'translateX(0)');
            ths.selector.css('display', 'none');
            ths.icon.removeClass('is-active');
        }
    }
    hamburger.click(function () {
        mobmnu.open();
    });
    blocker.click(function () {
        mobmnu.close();
    });

    $('.content').fullpage({
        //Navigation
        menu: '.top-mnu, .mobile-menu',
        //lockAnchors: false,
        anchors: ['we_are', 'how_it_works', 'features', 'blog', 'contacts'],
        navigation: true,
        navigationPosition: 'right',
        //navigationTooltips:  ['home', 'about-us', 'about-1', 'about-2', 'about-3', 'service', 'we-are', 'call'],
        //showActiveTooltip: false,
        //slidesNavigation: false,
        //slidesNavPosition: 'bottom',

        //Scrolling
        css3: true,
        scrollingSpeed: 700,
        autoScrolling: true,
        fitToSection: true,
        //fitToSectionDelay: 1000,
        scrollBar: false,
        easing: 'easeInOutCubic',
        //easingcss3: 'cubic-bezier(0, 0, 0.5, 2)',
        //loopBottom: false,
        //loopTop: false,
        //loopHorizontal: true,
        //continuousVertical: false,
        //continuousHorizontal: false,
        //scrollHorizontally: true,
        //interlockedSlides: false,
        //dragAndMove: true,
        // offsetSections: false,
        // resetSliders: false,
        // fadingEffect: true,
        normalScrollElements: '#conf, .mfp-content',
        //scrollOverflow: true,
        //scrollOverflowReset: true,
        //scrollOverflowOptions: null,
        // touchSensitivity: 15,
        // normalScrollElementTouchThreshold: 5,
        bigSectionsDestination: 'top',

        //Accessibility
        // keyboardScrolling: true,
        // animateAnchor: true,
        // recordHistory: true,

        //Design
        controlArrows: false,
        //verticalCentered: true,
        //sectionsColor : ['#ccc', '#fff'],
        paddingTop: '0px',
        //paddingBottom: '0px',
        //fixedElements: '#my-header, #my-aside-L, #my-footer',
        //responsiveWidth: 700,
        //responsiveHeight: 350,
        //responsiveSlides: true,
        //parallax: true,
        //parallaxOptions: {type: 'reveal', percentage: 62, property: 'translate'},

        //Custom selectors
        sectionSelector: '.sect',
        //slideSelector: '.slide',
        lazyLoading: true,

        //events
        onLeave: function (index, nextIndex, direction) {
            mobmnu.close();
            $('#toTop').fadeIn();
            if (index == 2 && direction == 'up') {
                $('#toTop').fadeOut();
            }
        },
        afterLoad: function (anchorLink, index) {
            if (index == 1) {
                $('#toTop').fadeOut();
            }
            var how_it_works = $('.fp-viewing-how_it_works');
            var features = $('.fp-viewing-features');
            var blog = $('.fp-viewing-blog');
            var contacts = $('.fp-viewing-contacts');
            var how_it_works_active = how_it_works.find('.active');
            var features_active = features.find('.active');
            var blog_active = blog.find('.active');
            var contacts_active = contacts.find('.active');

            //HOW IT WORKS
            var how_it_works_img = how_it_works_active.find('.img').find('img');
            var how_it_works_h3 = how_it_works_active.find('.h3');
            var how_it_works_desc = how_it_works_active.find('p');
            how_it_works_img.addClass('animate-img-2');
            how_it_works_h3.addClass('h-anim');
            setTimeout(function () {
                how_it_works_desc.css('opacity', 1);
            }, 500)
            //FEATURES
            var features_img = features_active.find('.img').find('img');
            var features_h3 = features_active.find('.h3');
            var features_desc = features_active.find('p');
            features_img.addClass('animate-img-3');
            features_h3.addClass('h-anim');
            setTimeout(function () {
                features_desc.css('opacity', 1);
            }, 500)
            //BLOG
            var blog_img = blog_active.find('.img').find('img');
            var blog_h3 = blog_active.find('.h3');
            var blog_desc = blog_active.find('p');
            blog_img.addClass('animate-img-4');
            blog_h3.addClass('h-anim');
            setTimeout(function () {
                blog_desc.css('opacity', 1);
            }, 500)
            //CONTACTS
            var contacts_img = contacts_active.find('.footer-img').find('img');
            var contacts_h3 = contacts_active.find('.h3');
            var contacts_desc = contacts_active.find('.desc');
            var contacts_h5 = contacts_active.find('.h5');
            var contacts_buttons = contacts_active.find('.buttons').find('img');
            var contacts_left_input = contacts_active.find('.left-input');
            var contacts_right_input = contacts_active.find('.right-input');
            contacts_img.addClass('animate-img-5');
            setTimeout(function () {
                contacts_h3.addClass('h-anim');
            }, 300);
            setTimeout(function () {
                contacts_h5.each(function (i) {
                    var ths = $(this);
                    setInterval(function () {
                        ths.css('opacity', 1);
                    }, i * 1000);
                })
            }, 800);
            setTimeout(function () {
                contacts_left_input.addClass('left-input-anim');
                contacts_right_input.addClass('right-input-anim');
            }, 1300);
            setTimeout(function () {
                contacts_buttons.each(function (i) {
                    var ths = $(this);
                    setInterval(function () {
                        ths.addClass('h-anim');
                    }, i * 150);
                })
            }, 1800);
        },
        afterRender: function () {
        },
        afterResize: function () {
        },
        afterResponsive: function (isResponsive) {
        },
        afterSlideLoad: function (anchorLink, index, slideAnchor, slideIndex) {
        },
        onSlideLeave: function (anchorLink, index, slideIndex, direction, nextSlideIndex) {
        }
    });

    var yesss = $('.subject-success');
    $(".form").submit(function (e) {
        e.preventDefault();
        var th = $(this);
        $.ajax({
            url: "mail.php",
            type: "POST",
            data: th.serialize()
        }).done(function () {
            yesss.css({'display': 'block'});
            setTimeout(function () {
                yesss.css({'opacity': 1});
            }, 100)
            setTimeout(function () {
                yesss.css({'opacity': 0});
            }, 5000)
            setTimeout(function () {
                yesss.css({'display': 'none'});
            }, 5500)
            setTimeout(function () {
                th.trigger("reset");
            }, 1000);
        });
    });

    $(".phone").inputmask("+7 (999) 999-99-99");

    var wind_height = window.innerHeight;
    var doc_height
    var ua = navigator.userAgent.toLowerCase();
    var isAndroid = ua.indexOf("android") > -1;
    if (isAndroid) {
        if ($('html').hasClass('keyboard-open')) {
            console.log("It's not android");
        } else {
            $('input').focus(function () {
                doc_height = wind_height;
                $('html').css('height', doc_height).addClass('keyboard-open');
            })
            $('input').blur(function () {
                $('html').css('height', '100%').removeClass('keyboard-open');
            })
        }
    } else {
        console.log("It's not android");
    }
});