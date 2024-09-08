function findWordInGrid(grid, word) {
    const rows = grid.length;
    const cols = grid[0].length;
    const wordLength = word.length;

    // Helper function to check if a word exists starting from (row, col) in a specific direction
    function checkDirection(row, col, rowDir, colDir) {
        for (let i = 0; i < wordLength; i++) {
            const newRow = row + i * rowDir;
            const newCol = col + i * colDir;
            if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols || grid[newRow][newCol] !== word[i]) {
                return false;
            }
        }
        return true;
    }

    // Directions: right, left, down, up, down-right, down-left, up-right, up-left
    const directions = [
        [0, 1],  // right
        [0, -1], // left
        [1, 0],  // down
        [-1, 0], // up
        [1, 1],  // down-right
        [1, -1], // down-left
        [-1, 1], // up-right
        [-1, -1] // up-left
    ];

    for (let row = 0; row < rows; row++) {
        for (let col = 0; col < cols; col++) {
            for (const [rowDir, colDir] of directions) {
                if (checkDirection(row, col, rowDir, colDir)) {
                    return { start: [row, col], direction: [rowDir, colDir] };
                }
            }
        }
    }

    return null;  // Word not found
}

// Example usage:
const grid = [
    "NFYBUQQDCELMUPOHRRGUJ".split(''),
    "RRMRETNIRPBLSHFSYDESK".split(''),
    "RPNCJGCTIUSISSMSHDOWK".split(''),
    "FFOEMITJISEJORVNCHQPA".split(''),
    "AAEZSUBLVQYABVQDRPTQE".split(''),
    "MMIDWWDELCIBUCYMAGFZR".split(''),
    "EGOSSIPHOTOCOPIERKNEB".split(''),
    "ZWJONMOWTICCTQSREEIH".split(''),
    "VOHGYBGMUBMKNUUEIYNIC".split(''),
    "TCOINYCRGKKYEJCLHBEHN".split(''),
    "SCOMPUTERXSAICZONOTCU".split(''),
    "IZTEYJTJNUQLLUAOSAOAL".split(''),
    "NWVBREAKROOMCSSCHRFMX".split(''),
    "OMEETINGCBPISTARLDIEE".split(''),
    "ISECRETARYLIGOLEIFVEC".split(''),
    "TOLHDTESHHSLIMATXFEFG".split(''),
    "PNFLEIGZZTEEHERAPYZFI".split(''),
    "EQHFIFIUAOSANRYWIRKOJ".split(''),
    "CHUUIVJNTOSICKLEAVECA".split(''),
    "EWBQZCTUCWENOHPELETMS".split(''),
    "REYASCEYVQSOAPGPULZSQ".split('')
];

// Get the word to find from command line arguments
const word = process.argv[2];
if (!word) {
    console.error("Please provide a word to find as a command line argument.");
    process.exit(1);
}

const result = findWordInGrid(grid, word);

if (result) {
    console.log(`Word found starting at ${result.start} in direction ${result.direction}`);
} else {
    console.log("Word not found");
}
