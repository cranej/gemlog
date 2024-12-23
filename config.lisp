(config site-title "cranej's personal site")
(config site-base-url "https://cranejin.com")

(set-stages
 (list (mk-stage ("public/gemini/" :name "Index Gemtext"
                                   :index-config '("index.gmi" "index.gmi"))
                 (is-type "gmi") apply-template
                 (is-type "org") (copy-as-type "txt" t)
                 (is-type "rst") (copy-as-type "txt" t)
                 t copy)
       (mk-stage ("public/www/" :name "Gemini site to html")
                 (is-type "gmi") gemtext->html
                 (glob-match "**/*.rst.txt") rst->html
                 t copy)))

(rewrite-url-of ".rst.txt")

(be-verbose)
