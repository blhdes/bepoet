import Foundation

// Simple test for syllable counter
func testSyllableCounter() {
    let testCases: [(word: String, expected: Int)] = [
        ("hello", 2),
        ("world", 1),
        ("poetry", 3),
        ("haiku", 2),
        ("five", 1),
        ("seven", 2),
        ("five", 1),
        ("the", 1),
        ("true", 1),
        ("fire", 1), // or 2 depending on pronunciation
        ("queue", 1), // or 2
        ("poet", 2),
        ("old", 1),
        ("pond", 1),
        ("silent", 2),
        ("frog", 1),
        ("jumps", 1),
        ("in", 1),
        ("splash", 1),
        ("again", 2),
        ("silence", 2),
        ("cherry", 2),
        ("blossoms", 2),
        ("spring", 1),
        ("rain", 1),
        ("mountain", 2),
        ("river", 2),
        ("ocean", 2),
        ("wind", 1),
        ("sky", 1),
        ("sun", 1),
        ("moon", 1),
        ("star", 1),
        ("tree", 1),
        ("leaf", 1),
        ("flower", 2),
        ("green", 1),
        ("blue", 1),
        ("red", 1),
        ("yellow", 2),
        ("purple", 2),
        ("orange", 2),
        ("black", 1),
        ("white", 1),
        ("love", 1),
        ("loss", 1),
        ("joy", 1),
        ("peace", 1),
        ("hope", 1),
        ("dream", 1),
        ("sleep", 1),
        ("wake", 1),
        ("walk", 1),
        ("talk", 1),
        ("see", 1),
        ("look", 1),
        ("feel", 1),
        ("know", 1),
        ("go", 1),
        ("come", 1),
        ("give", 1),
        ("take", 1),
        ("make", 1),
        ("can", 1),
        ("will", 1),
        ("shall", 1),
        ("may", 1),
        ("might", 1),
        ("must", 1),
        ("should", 1),
        ("would", 1),
        ("could", 1),
        ("did", 1),
        ("done", 1),
        ("been", 1),
        ("have", 1),
        ("has", 1),
        ("had", 1),
        ("is", 1),
        ("am", 1),
        ("are", 1),
        ("was", 1),
        ("were", 1),
        ("be", 1),
        ("being", 2),
        ("been", 1),
    ]
    
    var passed = 0
    var failed = 0
    
    for testCase in testCases {
        let actual = SyllableCounter.countSyllables(in: testCase.word)
        if actual == testCase.expected {
            passed += 1
        } else {
            failed += 1
            print("❌ Failed: '\(testCase.word)' expected \(testCase.expected), got \(actual)")
        }
    }
    
    print("✅ Passed: \(passed), ❌ Failed: \(failed)")
    
    // Test some haiku lines
    let haikuTests: [(line: String, expected: Int)] = [
        ("Old pond silent", 4), // old(1) pond(1) si-lent(2) = 4
        ("A frog jumps in— splash!", 5), // a(1) frog(1) jumps(1) in(1) splash(1) = 5
        ("Silence again.", 4), // si-lence(2) a-gain(2) = 4
    ]
    
    print("\n--- Haiku Line Tests ---")
    for test in haikuTests {
        let actual = SyllableCounter.countSyllables(in: test.line)
        if actual == test.expected {
            print("✅ '\(test.line)' = \(actual) syllables")
        } else {
            print("❌ '\(test.line)' expected \(test.expected), got \(actual)")
        }
    }
}

// Run the test
testSyllableCounter()