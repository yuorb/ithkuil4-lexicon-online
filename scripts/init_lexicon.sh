# Check Deno
if ! command -v deno &> /dev/null
then
    echo "You need to install Deno before running this script"
    exit 127
fi

# Generate `lexicon.json``
mkdir -p packages && cd packages
if [ -d "lexicon-json" ] 
then
    echo "Directory \"lexicon-json\" has existed. Skipped \"git clone\"."
else
    git clone --depth 1 https://github.com/Circulus-Ithkuilicus-Sinice-Loquentium/lexicon-json.git
fi
cd lexicon-json
deno task json

# Copy the `lexicon.json`
cd ../..
mkdir -p src/data
cp packages/lexicon-json/output/lexicon.json src/data/lexicon.ts
sed -i '1h;1!H;$!d;x;s/.*/const lexicon: { root: string, refers?: string, stems?: [ { "BSC": string, "CTE": string, "CSV": string, "OBJ": string } | string, { "BSC": string, "CTE": string, "CSV": string, "OBJ": string } | string, { "BSC": string, "CTE": string, "CSV": string, "OBJ": string } | string ], notes?: string }[] = &; export default lexicon;/' src/data/lexicon.ts