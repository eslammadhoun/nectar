#!/bin/bash
cd /Users/mac/StudioProjects/nectar/lib

# Replace Color(0xFF5383EC) - Google Blue
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFF5383EC)/AppTheme.googleBlue/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xff5383ec)/AppTheme.googleBlue/g' {} +

# Replace Color(0xFF4A66AC) - Facebook Blue
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFF4A66AC)/AppTheme.facebookBlue/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xff4a66ac)/AppTheme.facebookBlue/g' {} +

# Replace Color(0xFF828282) - Light Grey
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFF828282)/AppTheme.lightGrey/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xff828282)/AppTheme.lightGrey/g' {} +

# Replace Color(0xFFFCFCFC) - Light Background
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFFFCFCFC)/AppTheme.lightBackground/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xfffcfcfc)/AppTheme.lightBackground/g' {} +

# Replace Color(0xFF7C7C7C) - Secondary Text
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFF7C7C7C)/AppTheme.secondaryText/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xff7c7c7c)/AppTheme.secondaryText/g' {} +

# Replace Color(0xFFE0E0E0) - Border Grey
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xFFE0E0E0)/AppTheme.borderGrey/g' {} +
find . -name "*.dart" -type f -exec sed -i '' 's/Color(0xffe0e0e0)/AppTheme.borderGrey/g' {} +

echo "✅ Color patch complete!"
