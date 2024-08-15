var __classPrivateFieldSet = (this && this.__classPrivateFieldSet) || function (receiver, state, value, kind, f) {
    if (kind === "m") throw new TypeError("Private method is not writable");
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a setter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot write private member to an object whose class did not declare it");
    return (kind === "a" ? f.call(receiver, value) : f ? f.value = value : state.set(receiver, value)), value;
};
var __classPrivateFieldGet = (this && this.__classPrivateFieldGet) || function (receiver, state, kind, f) {
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a getter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot read private member from an object whose class did not declare it");
    return kind === "m" ? f : kind === "a" ? f.call(receiver) : f ? f.value : state.get(receiver);
};
var _Draw_ctx;
import CodeMirror from 'codemirror';
import 'codemirror/mode/javascript/javascript';
import 'codemirror/addon/mode/simple';
let editor = CodeMirror.fromTextArea(document.getElementById('code'), {
    lineNumbers: true,
    mode: 'javascript',
    theme: 'neo',
});
function parser(input) {
    let r = [];
    let lines = input.split("\n");
    let line = 0;
    let column = 0;
    try {
        for (; line < lines.length; line++) {
            let chars = lines[line].split("");
            let lexemes = [];
            for (column = 0; column < chars.length; column++) {
                let char = chars[column];
                switch (char) {
                    // skip whitespace
                    case "\t":
                    case "":
                    case " ":
                        continue;
                    case "/": // skip comment
                        if (chars[column + 1] === "/") {
                            while (column < chars.length) {
                                column++;
                                char = chars[column];
                            }
                            continue;
                        }
                        break;
                    case '"': {
                        column++; // skip "
                        char = chars[column];
                        let start = column;
                        while (column < chars.length && char !== '"') {
                            column++;
                            char = chars[column];
                        }
                        if (char !== '"') {
                            throw {
                                name: "LexerError",
                                message: "Unterminated String",
                                from: start,
                                to: column,
                            };
                        }
                        lexemes.push(lines[line].substring(start, column++));
                        break;
                    }
                    default: {
                        let start = column;
                        while (column < chars.length && char !== " ") {
                            column++;
                            char = chars[column];
                        }
                        let l = lines[line].substring(start, column);
                        let firstChar = l.charAt(0);
                        if (firstChar >= "0" && firstChar <= "9") {
                            lexemes.push(parseInt(l));
                        }
                        else {
                            lexemes.push(l);
                        }
                    }
                }
            }
            if (lexemes.length) {
                r.push({
                    operation: lexemes[0],
                    arguments: lexemes.slice(1),
                    line,
                    column,
                });
            }
        }
    }
    catch (e) {
        throw new Error(`${e.message} in line ${line + 1} and column ${column + 1}`);
    }
    return r;
}
class Draw {
    constructor() {
        Object.defineProperty(this, "board", {
            enumerable: true,
            configurable: true,
            writable: true,
            value: void 0
        });
        _Draw_ctx.set(this, void 0);
        this.board = document.getElementById("board");
        if (this.board === null) {
            throw new Error("Failed to access canvas board");
        }
        __classPrivateFieldSet(this, _Draw_ctx, this.board.getContext("2d"), "f");
        this.board.height = 512;
        this.board.width = 512;
    }
    genErr(instruction, msg) {
        return {
            name: "ExecutionError",
            message: msg,
            from: instruction.column - instruction.operation.length,
            to: instruction.column,
        };
    }
    execute(instructions) {
        __classPrivateFieldGet(this, _Draw_ctx, "f")?.clearRect(0, 0, this.board.width, this.board.height);
        for (let i = 0; i < instructions.length; i++) {
            let instruction = instructions[i];
            try {
                switch (instruction.operation) {
                    case "COLOR":
                        if (instruction.arguments.length !== 1) {
                            throw this.genErr(instruction, "COLOR requires exactly one argument");
                        }
                        __classPrivateFieldGet(this, _Draw_ctx, "f").fillStyle = instruction.arguments[0];
                        __classPrivateFieldGet(this, _Draw_ctx, "f").strokeStyle = instruction.arguments[0];
                        break;
                    case "BOX": {
                        if (instruction.arguments.length !== 4) {
                            throw this.genErr(instruction, "BOX requires exactly four arguments (x,y,w,h)");
                        }
                        let [x, y, w, h] = instruction.arguments;
                        __classPrivateFieldGet(this, _Draw_ctx, "f").fillRect(x, y, w, h);
                        break;
                    }
                    case "WIDTH": {
                        if (instruction.arguments.length !== 1) {
                            throw this.genErr(instruction, "WIDTH requires exactly one argument (width)");
                        }
                        __classPrivateFieldGet(this, _Draw_ctx, "f").lineWidth = instruction.arguments[0];
                        break;
                    }
                    case "LINE": {
                        if (instruction.arguments.length !== 4) {
                            throw this.genErr(instruction, "LINE requires exactly four arguments (sx,sy,ex,ey)");
                        }
                        let [x, y, x1, y1] = instruction.arguments;
                        __classPrivateFieldGet(this, _Draw_ctx, "f").beginPath();
                        __classPrivateFieldGet(this, _Draw_ctx, "f").moveTo(x, y);
                        __classPrivateFieldGet(this, _Draw_ctx, "f").lineTo(x1, y1);
                        __classPrivateFieldGet(this, _Draw_ctx, "f").stroke();
                        break;
                    }
                    case "FONT": {
                        if (instruction.arguments.length != 1) {
                            throw this.genErr(instruction, "FONT requires exactly one argument (font)");
                        }
                        __classPrivateFieldGet(this, _Draw_ctx, "f").font = instruction.arguments[0];
                        break;
                    }
                    case "TEXT": {
                        if (instruction.arguments.length != 3) {
                            throw this.genErr(instruction, "TEXT requires exactly three arguments (x,y,text)");
                        }
                        let [x, y, text] = instruction.arguments;
                        __classPrivateFieldGet(this, _Draw_ctx, "f").fillText(text, x, y);
                        break;
                    }
                    default:
                        throw this.genErr(instruction, `Operation "${instruction.operation}" not defined (args:${instruction.arguments})`);
                }
                updateToast("");
            }
            catch (e) {
                let { line, column } = instruction;
                throw new Error(`${e.message} in line ${line + 1} and column ${column + 1}`);
            }
        }
    }
}
_Draw_ctx = new WeakMap();
// let editor: any = null;
let draw = null;
let errorToast = null;
//   let docs: HTMLDivElement | null = null;
//   function toggleDocs() {
//     docs!.classList.toggle("hidden");
//   }
function updateToast(text) {
    if (text) {
        errorToast.innerText = text;
        errorToast.classList.remove("hidden");
    }
    else {
        errorToast.classList.add("hidden");
    }
}
//   function shareURL() {
//     if (!navigator.clipboard) {
//       throw new Error("Failed to copy to clipboard");
//     }
//     errorToast!.innerText = "Copied the link to your creation to your clipboard :^)";
//     errorToast!.classList.remove("hidden");
//     setTimeout(() => {
//       errorToast!.classList.add("hidden");
//     }, 3000);
//     navigator.clipboard.writeText(window.location.href.split("?")[0] + "?i=" + btoa(editor?.getValue()));
//   }
//   function exportImg() {
//     let url = draw?.board!.toDataURL();
//     window.open(url, "_blank");
//   }
window.onerror = (msg) => {
    updateToast(msg);
    return false;
};
document.addEventListener("DOMContentLoaded", () => {
    CodeMirror.defineSimpleMode("codedraw", {
        start: [
            { regex: /"(?:[^\\]|\\.)*?(?:"|$)/, token: "string" },
            { regex: /[A-Z]/, token: "keyword" },
            { regex: /[a-z#]/, token: "atom" },
            {
                regex: /0x[a-f\d]+|[-+]?(?:\.\d+|\d+\.?\d*)(?:e[-+]?\d+)?/i,
                token: "number",
            },
            { regex: /[,\)\(]/, token: "operator" },
            { regex: /\/\/.*/, token: "comment" },
        ],
        meta: {
            lineComment: "//",
        },
    });
    errorToast = document.getElementById("error");
    // docs = document.getElementById("documentation") as HTMLDivElement;
    editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        mode: "codedraw",
        theme: "neo",
    });
    let args = new URLSearchParams(location.search).get("i");
    let text = `// click on [Documentation] for a list of instructions
  // click on [Share] to share your creations with friends
  // click on [Export] to generate an image from your drawing
  COLOR rgba(117,67,138,1)
  BOX 0 0 512 512
  COLOR white
  FONT "48px monospace"
  TEXT 130 260 "HELLO WORLD"
  TEXT 240 350 "<3"
  // made with <3 by xnacly :^)`;
    if (args?.length) {
        text = atob(args);
    }
    else {
        let t = localStorage.getItem("content");
        if (t) {
            text = t;
        }
    }
    draw = new Draw();
    editor.on("update", function () {
        let val = editor.getValue();
        if (val.length && !args?.length) {
            localStorage.setItem("content", val);
        }
        try {
            let instructions = parser(val);
            if (draw) {
                draw.execute(instructions);
            }
        }
        catch (e) {
            console.table(e);
            updateToast(e.message);
        }
    });
    editor?.setOption("value", text);
});
