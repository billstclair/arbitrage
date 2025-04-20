[Arbitrage](https://arbitrage.wtf) is an Automated Crypto Arbitrage trading system.

I have abandoned work on this. 
It's too hard to find pricing info.

For development:

$ cd .../arbitrage<br/>
$ elm reactor

Then aim your browser at http://localhost:8000/site/index.html

To build the Elm code into `site/elm.js`:

$ cd .../arbitrage<br/>
$ ./bin/build

## Emacs Lisp code for arbitrage.
## From my ~/.emacs file.

```
(defun arbitrage (&rest odds)
  (/ 1 (apply '+ (mapcar (lambda (x) (/ 1.0 x)) odds))))

(defun min-arbitrage-bet (arbitrage &rest odds)
  (let* ((denom (apply '+ (mapcar (lambda (x) (/ 1.0 x)) odds)))
         (bet (- (/ 1 arbitrage) denom)))
    (values bet (apply 'arbitrage bet odds))))
```
