# CRM Sales Funnel System

## Overview

The CRM system includes a comprehensive sales funnel feature that visualizes the sales pipeline, tracks deal progression through stages, and provides insights into conversion rates and bottlenecks. The funnel view helps sales teams understand where deals are in the pipeline and identify areas for improvement.

## Table of Contents

1. [Features](#features)
2. [Funnel Structure](#funnel-structure)
3. [API Reference](#api-reference)
4. [UI Components](#ui-components)
5. [Analytics](#analytics)
6. [Usage Examples](#usage-examples)
7. [Best Practices](#best-practices)

## Features

- **Visual Funnel Representation**: Trapezoidal stages showing deal flow
- **Stage Metrics**: Count, value, and conversion rate for each stage
- **Real-time Data**: Live data from Supabase database
- **Flexible Date Ranges**: Customizable reporting periods
- **Pipeline Insights**: Identify bottlenecks and best practices
- **Deal Tracking**: Track individual deals through stages
- **Comparison Analysis**: Compare current vs previous periods
- **Actionable Recommendations**: AI-powered insights and suggestions

## Funnel Structure

### Pipeline Stages

The sales funnel consists of sequential stages:

1. **Lead** - Initial contact/inquiry
2. **Qualified** - Lead meets qualification criteria
3. **Proposal** - Formal proposal submitted
4. **Negotiation** - Discussing terms and pricing
5. **Closed Won** - Deal successfully closed
6. **Closed Lost** - Deal was not won

### Stage Metrics

Each stage displays:
- **Deal Count**: Number of deals in the stage
- **Total Value**: Sum of all deal amounts
- **Conversion Rate**: Percentage moving to next stage
- **Drop-off Rate**: Percentage not converting
- **% of Total**: Percentage of total pipeline value

## API Reference

### CrmSalesFunnelService

The `CrmSalesFunnelService` class provides all funnel-related operations.

#### Getting Funnel Data

```dart
final funnelService = ref.read(crmSalesFunnelServiceProvider);

final funnelData = await funnelService.getSalesFunnelData(
  pipelineId: 'default',
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
);

print('Total Deals: ${funnelData.totalDeals}');
print('Overall Conversion: ${funnelData.overallConversionRate}%');
```

#### Moving Deals Between Stages

```dart
await funnelService.moveDealToStage(
  'deal-id',
  'new-stage-id',
  'user-id',
);
```

#### Getting Funnel Insights

```dart
final insights = await funnelService.getFunnelInsights('default');

print('Bottlenecks: ${insights.bottlenecks}');
print('Recommendations: ${insights.recommendations}');
```

#### Comparing Periods

```dart
final comparison = await funnelService.compareFunnelPeriods(
  pipelineId: 'default',
  currentStart: DateTime(2024, 1, 1),
  currentEnd: DateTime(2024, 3, 31),
  previousStart: DateTime(2023, 10, 1),
  previousEnd: DateTime(2023, 12, 31),
);

print('Deal Change: ${comparison.dealChange}');
print('Value Change: \$${comparison.valueChange}');
```

## UI Components

### SalesFunnelScreen

Full-screen funnel visualization with:
- Pipeline selector
- Date range picker
- Funnel metrics
- Stage-by-stage visualization
- Deal lists per stage
- Insights dialog

**Route:** `/crm/funnel`

**Features:**
- Trapezoidal funnel shape
- Color-coded stages
- Progress bars for conversion rates
- Deal cards with key information
- Bottleneck indicators
- Recommendations panel

### Funnel Stage Card

Displays:
- Stage name and color
- Deal count and value
- Conversion rate bar
- Drop-off percentage
- Top deals list
- Stage metrics

### Funnel Metrics Cards

Quick overview showing:
- Total Deals
- Conversion Rate
- Won Value
- Average Deal Size

## Analytics

### Conversion Rate Calculation

```dart
double _calculateConversionRate(int currentStageCount, int previousStageCount) {
  if (previousStageCount == 0) return 0;
  return (currentStageCount / previousStageCount) * 100;
}
```

### Drop-off Analysis

- Identifies stages with high drop-off rates (>50%)
- Highlights potential bottlenecks
- Provides specific recommendations

### Insights Generation

The system automatically generates insights:
- **Bottlenecks**: Stages with low conversion
- **Best Stage**: Highest conversion rate
- **Velocity**: Average time through pipeline
- **Recommendations**: Actionable suggestions

### Sample Insights

```
Bottlenecks:
- Proposal stage: 45% drop-off (target: <30%)
- Negotiation stage: 60% drop-off (target: <40%)

Best Performing Stage:
- Qualified stage: 85% conversion to Proposal

Recommendations:
- Review proposal template and pricing strategy
- Improve qualification criteria to reduce negotiations
- Focus on accelerating qualification process
```

## Usage Examples

### Basic Funnel Widget

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunnelWidget extends ConsumerWidget {
  const FunnelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final funnelService = ref.read(crmSalesFunnelServiceProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Funnel',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FutureBuilder<SalesFunnelData>(
              future: funnelService.getSalesFunnelData(
                pipelineId: 'default',
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final data = snapshot.data!;

                return Column(
                  children: data.stages.map((stage) {
                    return _buildStageCard(stage);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard(FunnelStageData stageData) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(stageData.stage.colorHex),
          child: Text(
            stageData.count.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(stageData.stage.name),
        subtitle: Text('\$${stageData.value.toStringAsFixed(0)}'),
        trailing: Text(
          '${stageData.conversionRate.toStringAsFixed(1)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: stageData.conversionRate > 50 ? Colors.green : Colors.orange,
          ),
        ),
      ),
    );
  }
}
```

### Funnel Analytics Dashboard

```dart
class FunnelAnalyticsScreen extends StatelessWidget {
  const FunnelAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Funnel Analytics')),
      body: Column(
        children: [
          // Quick metrics
          Expanded(
            flex: 1,
            child: _buildMetricsRow(),
          ),
          // Funnel visualization
          Expanded(
            flex: 3,
            child: SalesFunnelScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsRow() {
    return Consumer(
      builder: (context, ref, child) {
        final funnelService = ref.read(crmSalesFunnelServiceProvider);

        return FutureBuilder<SalesFunnelData>(
          future: funnelService.getSalesFunnelData(
            pipelineId: 'default',
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;

            return Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Conversion', '${data.overallConversionRate.toStringAsFixed(1)}%'),
                ),
                Expanded(
                  child: _buildMetricCard('Total Value', '\$${data.wonValue.toStringAsFixed(0)}'),
                ),
                Expanded(
                  child: _buildMetricCard('Avg Deal', '\$${data.averageDealSize.toStringAsFixed(0)}'),
                ),
                Expanded(
                  child: _buildMetricCard('Total Deals', data.totalDeals.toString()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label),
          ],
        ),
      ),
    );
  }
}
```

### Custom Date Range Funnel

```dart
class CustomFunnelView extends StatefulWidget {
  const CustomFunnelView({Key? key}) : super(key: key);

  @override
  State<CustomFunnelView> createState() => _CustomFunnelViewState();
}

class _CustomFunnelViewState extends State<CustomFunnelView> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Funnel'),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: _pickDateRange,
          ),
        ],
      ),
      body: FutureBuilder<SalesFunnelData>(
        future: ref.read(crmSalesFunnelServiceProvider).getSalesFunnelData(
          pipelineId: 'default',
          startDate: _startDate,
          endDate: _endDate,
        ),
        builder: (context, snapshot) {
          // Build funnel UI
          return Container();
        },
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }
}
```

## Data Models

### SalesFunnelData

```dart
class SalesFunnelData {
  final PipelineModel pipeline;
  final List<FunnelStageData> stages;
  final int totalDeals;
  final int wonDeals;
  final int lostDeals;
  final int openDeals;
  final double totalValue;
  final double wonValue;
  final double averageDealSize;
  final double overallConversionRate;
  final DateTime startDate;
  final DateTime endDate;
}
```

### FunnelStageData

```dart
class FunnelStageData {
  final PipelineStage stage;
  final List<DealModel> deals;
  final int count;
  final double value;
  final double percentageOfTotal;
  final double conversionRate;
  final double dropOffRate;
}
```

### FunnelInsights

```dart
class FunnelInsights {
  final List<String> bottlenecks;
  final String? bestPerformingStage;
  final double averageVelocity;
  final Map<String, double> trends;
  final List<String> recommendations;
}
```

### FunnelComparison

```dart
class FunnelComparison {
  final SalesFunnelData current;
  final SalesFunnelData previous;
  final int dealChange;
  final double valueChange;
  final double conversionChange;
}
```

## Best Practices

### Optimizing Conversion Rates

1. **Identify Bottlenecks**
   - Focus on stages with >50% drop-off
   - Analyze why deals aren't converting
   - Implement stage-specific improvements

2. **Qualification**
   - Improve qualification criteria
   - Filter out poor-fit leads earlier
   - Reduce time in early stages

3. **Process Improvement**
   - Streamline stage transitions
   - Automate routine tasks
   - Provide stage-specific guidance

4. **Sales Training**
   - Train on weak stages
   - Share best practices
   - Monitor improvement

### Stage Management

1. **Clear Stage Definitions**
   - Define entry/exit criteria
   - Document stage requirements
   - Ensure team alignment

2. **Stage Timing**
   - Set maximum stage duration
   - Track velocity
   - Accelerate stuck deals

3. **Deal Quality**
   - Monitor deal quality by stage
   - Set minimum deal thresholds
   - Focus on high-value opportunities

### Monitoring and Reporting

1. **Daily Review**
   - Check funnel health
   - Identify stuck deals
   - Monitor conversions

2. **Weekly Analysis**
   - Compare to previous week
   - Track trends
   - Adjust strategies

3. **Monthly Planning**
   - Review conversion rates
   - Forecast revenue
   - Set stage goals

### Data Quality

1. **Accurate Stage Assignment**
   - Ensure deals are in correct stages
   - Update stages promptly
   - Validate transitions

2. **Complete Deal Information**
   - Keep deal amounts current
   - Update contact information
   - Record relevant notes

3. **Regular Cleanup**
   - Remove closed deals from active pipeline
   - Merge duplicate deals
   - Archive old data

## Troubleshooting

### Common Issues

1. **Inaccurate Conversion Rates**
   - Check stage assignments
   - Verify deal status
   - Review date ranges

2. **Slow Performance**
   - Add database indexes
   - Cache funnel data
   - Limit date range

3. **Missing Deals**
   - Check pipeline assignment
   - Verify date filters
   - Review deal status

### Debugging

Enable logging:

```dart
// Enable Supabase debug logging
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  debug: true,
);
```

## Future Enhancements

- [ ] Drag-and-drop deal movement
- [ ] Funnel forecasting
- [ ] Stage customization UI
- [ ] Weighted pipeline value
- [ ] Multiple pipeline views
- [ ] Funnel templates
- [ ] Automated stage progression
- [ ] Deal velocity tracking
- [ ] Predictive analytics
- [ ] Mobile-optimized funnel
- [ ] Funnel benchmarking
- [ ] Integration with calendar/tasks

## Conclusion

The CRM sales funnel system provides a powerful visualization of the sales pipeline, helping teams understand deal flow, identify bottlenecks, and improve conversion rates. The real-time data and actionable insights enable data-driven decision making and continuous improvement of the sales process.

For more information, refer to:
- [Sales Funnel Best Practices](https://www.saleshandbook.com/sales-funnel/)
- [Pipeline Management Guide](https://www.salesopedia.com/pipeline-management/)
- [Conversion Rate Optimization](https://www.optimizely.com/optimization-glossary/conversion-rate-optimization/)
