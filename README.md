# table-layout

This package can be used to render character-based table layouts, which should be displayed with monospace fonts.

## Purpose

The focus of this library lies on rendering cells with different styles per column. Columns can be fixed in size or expanding to make content fit. Whenever content has to be cut, it is possible to indicate this with special strings (these are called cut marks). Columns can be positionally aligned as left, right or center and additionally aligned at certain character occurences, e.g. to display floating point numbers. Those specifications are then applied to a list of rows (currently only `String` is supported).

Typically cells are rendered as a grid, but it is also possible to render tables with simulated lines, including styling support. Such tables can use optional headers and multiple lines per cell. Multi-line content can be aligned vertically and text can be rendered justified.

## Examples

### Basic grid layout

Render some text rows as grid:
``` hs
putStrLn $ layoutToString [ ["top left", "top right"]
                          , ["bottom left", "bottom right"]
                          ]
                          [column expand left def def, column expand right def def]
```
`layoutToString` will join cells with a whitespace and rows with a newline character. The result is not spectacular but does look as expected:
```
top left       top right
bottom left bottom right
```
There are sensible default values for all column specification types, even for columns. We could have used just `def` for the first column.

### Number columns

Additionally some common types are provided. A particularly useful one is `numCol`:
``` hs
mapM_ putStrLn $ layoutToLines (map ((: []) . show) [1.2, 100.5, 0.037, 5000.00001]) [numCol]
```
We simply display the given numbers as a dot-aligned single column:
```
   1.2    
 100.5    
   3.7e-2 
5000.00001
```

### Readability and table layout

#### Improving grid readability

Big grids are usually not that readable, so to improve their readability two functions are provided:

- `altLines` will alternate functions applied to lines.
- `checkeredCells` will checker cells with 2 different functions.

A good way to use this would be the **ansi-terminal** package, provided you are using a terminal to output your text.

### Table layout and styles

Grids are fine, but sometimes we want to explicitly display a table, e.g. in a database application. This is where ```layoutTableToString``` comes in handy:

``` hs
putStrLn $ layoutTableToString [ rowGroup [["Jack", "184.74"]]
                               , rowGroup [["Jane", "162.2"]]]
                               def
                               [def , numCol] unicodeRoundS
```
A row group is a group of rows which form one cell, meaning that each line of a group is not visually seperated from the other ones. The second argument specifies an optional header, the third the column specifications and the style. This will yield the following result:

```
╭──────┬────────╮
│ Jack │ 184.74 │
├──────┼────────┤
│ Jane │ 162.2  │
╰──────┴────────╯
```




