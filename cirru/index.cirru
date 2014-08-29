doctype

html
  head
    title "Simple Chat"
    meta (:charset utf-8)
    script(:src dist/vendor.min.js)
    @if (@ dev)
      @block
        link (:rel stylesheet) (:href css/index.css)
        script (:defer) (:src build/main.js)
      @block
        link (:rel stylesheet) (:href dist/index.min.css)
        script (:defer) (:src dist/main.min.js)
  body