package foodchain
import "strings"
import "fmt"

const REFRAIN = "I don't know why she swallowed the fly. Perhaps she'll die."

var animals = [9] string {
    "",
    "fly",
    "spider",
    "bird",
    "cat",
    "dog",
    "goat",
    "cow",
    "horse",
}

func FirstLine(n int) string {

    const HEAD = "I know an old lady who swallowed a %s.\n"

    tails := [9] string {
        "",
        "",
        "It wriggled and jiggled and tickled inside her.\n", 
        "How absurd to swallow a bird!\n",
        "Imagine that, to swallow a cat!\n",
        "What a hog, to swallow a dog!\n",
        "Just opened her throat and swallowed a goat!\n",
        "I don't know how she swallowed a cow!\n",
        "She's dead, of course!",
    }

    return fmt.Sprintf(HEAD, animals[n]) + tails[n]
}

func VerseHead(v int) string {
    const HEAD = "She swallowed the %s to catch the %s"
	return fmt.Sprintf(HEAD, animals[v], animals[v-1])    
}

func VerseTail(v int) string {
    const STANDARD_TAIL = ".\n"
    const VERSE_3_TAIL = " that wriggled and jiggled and tickled inside her.\n"
    if v == 3 {
        return VERSE_3_TAIL
    } else {
        return STANDARD_TAIL
    }
}

func Verse(v int) string {
    result := FirstLine(v)
    if v < 8 {
        for i := v; i > 1; i-- {
            result += VerseHead(i) + VerseTail(i)
        }
        result += REFRAIN
    }
    return result
}

func Verses(start, end int) string {
    var result []string
    for v := start; v <= end; v++ {
        result = append(result, Verse(v))
    }
    return strings.Join(result, "\n\n")
}

func Song() string {
    return Verses(1, 8)
}
