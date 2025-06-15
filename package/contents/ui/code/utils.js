// a rudimentary way to parse gdbus GVariant into a valid js object
function parseGVariant(str) {
    str = gVariantTupleToArray(str);
    str = str.trim().replace(/^\([']?/, "") // remove starting ( or ('
        .replace(/[']?[,]?\)$/, ""); // remove ending ,) or ',)

    // remove GVariant typing thingy e.g <(uint32 ...,)> or <@as ...> <...> <[...]>
    str = str.replace(/<[\(]?\s*(.+?)[,]?\s*[\)]?>/g, "$1").replace(/@as |uint32 /g, '');

    if (str === "") return "";
    if (str === "true") return true;
    if (str === "false") return false;
    if (str === "null") return null;
    if (/^-?\d+(\.\d+)?$/.test(str)) return Number(str);

    // try to parse as array or dictionary
    if (/^[\[]?[\{]?.*[\]]?[\}]?$/.test(str)) {
        try {
            return JSON.parse(str.replace(/'null'/g, "null").replace(/'/g, '"'));
        } catch (e) {
            return str;
        }
    }
    return str.replace(/^['"]|['"]$/g, "").trim();
}

// convert GVariant tuples to arrays
function gVariantTupleToArray(str) {
    // convert all tuples like (..., ...) arrays [..., ...]
    return str.replace(/\(([^()]+?)\)/g, (_, inner) => {
        // only replace if it's NOT inside a JSON-style key or between quotes
        if (/^[^:][^']+,[^:][^']+$/.test(inner)) {
            return `[${inner}]`;
        }
        return `(${inner})`;
    });
}
