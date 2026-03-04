#!/bin/bash
# Coverage Report Generator

echo "Generating test coverage report..."

# Run tests with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html

# Display coverage summary
lcov --summary coverage/lcov.info

# Check coverage threshold
COVERAGE=$(lcov --summary coverage/lcov.info | grep lines | grep -oP '\d+\.\d+' | head -1)
MIN_COVERAGE=80

echo ""
echo "Coverage: $COVERAGE% (minimum: $MIN_COVERAGE%)"

if (( $(echo "$COVERAGE >= $MIN_COVERAGE" | bc -l) )); then
    echo "✅ Coverage requirement met!"
    exit 0
else
    echo "❌ Coverage requirement not met!"
    exit 1
fi
