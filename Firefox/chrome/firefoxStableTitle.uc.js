(function () {
    setTimeout(() => {
        try {
            function titleCallback() {
                if (document) {
                    document.title = "Mozilla Firefox";
                }
            };

            if (document) {
                document.title = "Mozilla Firefox";
            };
        } catch (e) {
            console.log("not loaded?");
        };

        window.addEventListener('DOMContentLoaded', titleCallback, false);
        window.addEventListener('unload', titleCallback, false);
        gBrowser.tabs.onActivated.addListener(titleCallback);
        gBrowser.tabContainer.addEventListener('TabOpen', titleCallback, false);
        gBrowser.tabContainer.addEventListener('TabClose', titleCallback, false);
        gBrowser.tabContainer.addEventListener('TabSelect', titleCallback, false);
        gBrowser.tabContainer.addEventListener('SSTabRestoring', titleCallback, false);
        gBrowser.tabContainer.addEventListener('SSTabRestored', titleCallback, false);
    }, 1000);
})();