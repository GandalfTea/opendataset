"use strict";
// Data Sanitation
exports.__esModule = true;
exports.validate = exports.dtype = void 0;
var dtype;
(function (dtype) {
    dtype[dtype["DS_NAME"] = 0] = "DS_NAME";
    dtype[dtype["USERNAME"] = 1] = "USERNAME";
    dtype[dtype["EMAIL"] = 2] = "EMAIL";
    dtype[dtype["INT"] = 3] = "INT";
    dtype[dtype["UINT"] = 4] = "UINT";
})(dtype || (dtype = {}));
exports.dtype = dtype;
;
function validate(input, data_type) {
    switch (data_type) {
        case dtype.DS_NAME:
            return /^[A-Za-z][A-Za-z0-9_\-@,.'"$%^&*() ]{4,49}/.test(input);
            break;
        case dtype.USERNAME:
            return /^[a-za-z][a-za-z0-9_]{4,29}/.test(input);
            break;
        case dtype.EMAIL:
            return /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/.test(input);
            break;
        case dtype.INT:
            return Number.isInteger(input);
        case dtype.UINT:
            if (Number.isInteger(input)) {
                if (input > 0)
                    return true;
            }
            return false;
        default:
            return false;
    }
}
exports.validate = validate;
