# CRM Sales Reports System

## Overview

The CRM system includes a comprehensive sales reports feature that provides detailed analytics and insights into sales performance, pipeline health, and team productivity. The reports are generated in real-time from the database and can be customized by date range.

## Table of Contents

1. [Features](#features)
2. [Report Types](#report-types)
3. [API Reference](#api-reference)
4. [UI Components](#ui-components)
5. [Usage Examples](#usage-examples)
6. [Best Practices](#best-practices)

## Features

- **Real-time Data**: Reports are generated from live database data
- **Flexible Date Ranges**: Customizable date periods (7 days, 30 days, 90 days, year-to-date)
- **Multiple Report Types**: Summary, pipeline, period-based, top performers, activity
- **Key Metrics**: Revenue, deals, conversion rates, win rates
- **Visual Cards**: Easy-to-read metric cards and statistics
- **Responsive Design**: Works on all screen sizes
- **Drill-down**: Detailed views for each report type
- **Export Ready**: Structured data for CSV/PDF export

## Report Types

### 1. Sales Summary Report

Overview of overall sales performance including:
- Total Revenue (won deals)
- Total Deals (all deals)
- Won Deals count
- Conversion Rate (%)
- Average Deal Size
- Win Rate (%)
- Loss Rate (%)
- Open Deals count

**Use Cases:**
- Executive dashboard
- Monthly/quarterly performance review
- Quick performance snapshot

### 2. Pipeline Performance Report

Breakdown of deals by pipeline stage showing:
- Stage name
- Total deals in stage
- Won deals in stage
- Revenue from won deals
- Conversion rate per stage

**Use Cases:**
- Pipeline health analysis
- Identify bottlenecks
- Stage performance comparison
- Sales forecasting

### 3. Sales by Period Report

Time-based sales analysis showing:
- Period (daily, weekly, monthly, quarterly, yearly)
- Deals count per period
- Revenue per period

**Use Cases:**
- Trend analysis
- Seasonal patterns
- Growth tracking
- Forecasting

### 4. Top Performers Report

Ranking of best-performing clients based on:
- Total revenue generated
- Number of deals
- Won deals count
- Average deal size

**Use Cases:**
- Identify key accounts
- Client relationship prioritization
- Sales strategy planning
- Reward programs

### 5. Activity Report

Summary of CRM activity including:
- Calls count
- Emails count
- Meetings count
- Notes added
- Other activities

**Use Cases:**
- Team productivity analysis
- Engagement tracking
- Activity trend monitoring
- Performance coaching

## API Reference

### CrmReportsService

The `CrmReportsService` class provides methods to generate all report types.

#### Getting Sales Summary Report

```dart
final reportsService = ref.read(crmReportsServiceProvider);

final report = await reportsService.getSalesSummaryReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
);

print('Total Revenue: \$${report.wonRevenue}');
print('Conversion Rate: ${report.conversionRate}%');
```

#### Getting Pipeline Performance Report

```dart
final report = await reportsService.getPipelinePerformanceReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
);

for (final stage in report.stages) {
  print('${stage.stageName}: ${stage.totalDeals} deals, \$${stage.revenue}');
}
```

#### Getting Sales by Period Report

```dart
final report = await reportsService.getSalesByPeriodReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
  periodType: PeriodType.monthly,
);

for (final period in report.periods) {
  print('${period.period}: \$${period.revenue}');
}
```

#### Getting Top Performers Report

```dart
final report = await reportsService.getTopPerformersReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
  limit: 10,
);

for (final performer in report.performers) {
  print('${performer.name}: \$${performer.revenue}');
}
```

#### Getting Activity Report

```dart
final report = await reportsService.getActivityReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
);

print('Total Activities: ${report.totalActivities}');
print('Calls: ${report.activityCounts['call']}');
print('Emails: ${report.activityCounts['email']}');
```

#### Getting Detailed Report

```dart
final report = await reportsService.getDetailedSalesReport(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 12, 31),
);

// Contains summary, byPeriod, and topPerformers
```

## UI Components

### SalesReportsScreen

Full-screen report viewer with:
- Date range picker
- Report type tabs/filters
- Metric cards with visual icons
- Detailed statistics
- Responsive layout

**Route:** `/crm/reports`

**Features:**
- Quick date range buttons (7 days, 30 days, 90 days, this year)
- Tab-based navigation between report types
- Visual metric cards with color coding
- Loading states
- Error handling

### Report Cards

Each report type uses specialized cards:
- **Metric Cards**: Display key metrics with icons
- **Stage Cards**: Show pipeline stage performance
- **Period Cards**: Display time-based data
- **Rank Cards**: Show top performers with rankings
- **Activity Cards**: Show activity counts

## Usage Examples

### Basic Report Dashboard

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsDashboard extends ConsumerWidget {
  const ReportsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsService = ref.read(crmReportsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Reports'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<SalesSummaryReport>(
        future: reportsService.getSalesSummaryReport(
          startDate: DateTime.now().subtract(Duration(days: 30)),
          endDate: DateTime.now(),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final report = snapshot.data!;

          return GridView.count(
            crossAxisCount: 2,
            children: [
              _buildMetricCard(
                'Total Revenue',
                '\$${report.wonRevenue.toStringAsFixed(0)}',
                Icons.attach_money,
                Colors.green,
              ),
              _buildMetricCard(
                'Conversion Rate',
                '${report.conversionRate.toStringAsFixed(1)}%',
                Icons.trending_up,
                Colors.blue,
              ),
            ],
          );
        },
      ),
    );
  }
}
```

### Report Widget for Dashboard

```dart
class SalesSummaryWidget extends StatelessWidget {
  const SalesSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final reportsService = ref.read(crmReportsServiceProvider);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This Month',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                FutureBuilder<SalesSummaryReport>(
                  future: reportsService.getSalesSummaryReport(
                    startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
                    endDate: DateTime.now(),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    final report = snapshot.data!;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Revenue', '\$${report.wonRevenue.toStringAsFixed(0)}'),
                        _buildStat('Deals', report.wonDeals.toString()),
                        _buildStat('Rate', '${report.conversionRate.toStringAsFixed(1)}%'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}
```

### Custom Date Range Report

```dart
class CustomReport extends StatefulWidget {
  const CustomReport({Key? key}) : super(key: key);

  @override
  State<CustomReport> createState() => _CustomReportState();
}

class _CustomReportState extends State<CustomReport> {
  DateTime _startDate = DateTime(2024, 1, 1);
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Date picker
          ElevatedButton(
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                initialDateRange: DateTimeRange(
                  start: _startDate,
                  end: _endDate,
                ),
              );

              if (picked != null) {
                setState(() {
                  _startDate = picked.start;
                  _endDate = picked.end;
                });
              }
            },
            child: Text('Select Date Range'),
          ),

          // Report content
          Expanded(
            child: FutureBuilder<SalesSummaryReport>(
              future: ref.read(crmReportsServiceProvider).getSalesSummaryReport(
                startDate: _startDate,
                endDate: _endDate,
              ),
              builder: (context, snapshot) {
                // Build report UI
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## Report Models

### SalesSummaryReport

```dart
class SalesSummaryReport {
  final int totalDeals;
  final int wonDeals;
  final int lostDeals;
  final int openDeals;
  final double totalRevenue;
  final double wonRevenue;
  final double averageDealSize;
  final double conversionRate;
  final double winRate;
  final double lossRate;
  final DateTime startDate;
  final DateTime endDate;
}
```

### PipelinePerformanceReport

```dart
class PipelinePerformanceReport {
  final List<PipelineStageReport> stages;
  final DateTime startDate;
  final DateTime endDate;
}

class PipelineStageReport {
  final String stageName;
  final int totalDeals;
  final int wonDeals;
  final double revenue;
  final double conversionRate;
}
```

### SalesByPeriodReport

```dart
class SalesByPeriodReport {
  final List<PeriodData> periods;
  final PeriodType periodType;
  final DateTime startDate;
  final DateTime endDate;
}

class PeriodData {
  final String period;
  final List<DealModel> deals;
  final double revenue;
}
```

### TopPerformersReport

```dart
class TopPerformersReport {
  final List<PerformerData> performers;
  final DateTime startDate;
  final DateTime endDate;
  final int limit;
}

class PerformerData {
  final String name;
  final int totalDeals;
  final int wonDeals;
  final double revenue;
  final double averageDealSize;
}
```

### ActivityReport

```dart
class ActivityReport {
  final Map<String, int> activityCounts;
  final int totalActivities;
  final DateTime startDate;
  final DateTime endDate;
}
```

## Best Practices

### When to Use Each Report Type

1. **Daily Standup/Team Meeting**
   - Use Activity Report
   - Check today's metrics
   - Review pipeline changes

2. **Weekly Review**
   - Use Sales Summary Report
   - Check top performers
   - Review period trends

3. **Monthly Business Review**
   - Use Pipeline Performance Report
   - Analyze conversion rates
   - Identify bottlenecks

4. **Quarterly Planning**
   - Use Detailed Sales Report
   - Compare periods
   - Forecast future performance

### Performance Optimization

1. **Caching**
   - Cache reports for 5-15 minutes
   - Use FutureBuilder for async loading
   - Implement refresh indicators

2. **Pagination**
   - Limit top performers to 10-20
   - Paginate activity reports
   - Lazy load historical data

3. **Filtering**
   - Use database-level filtering
   - Index date columns
   - Avoid client-side filtering for large datasets

### Data Accuracy

1. **Consistent Calculations**
   - Use same logic across reports
   - Document calculation methods
   - Validate against source data

2. **Date Handling**
   - Use UTC timestamps
   - Handle timezones properly
   - Clear date range boundaries

3. **Null Handling**
   - Handle missing data gracefully
   - Provide default values
   - Show meaningful error messages

### User Experience

1. **Loading States**
   - Show progress indicators
   - Indicate what is being loaded
   - Provide feedback

2. **Error Handling**
   - Show clear error messages
   - Offer retry options
   - Log errors for debugging

3. **Visual Design**
   - Use consistent colors
   - Organize information clearly
   - Highlight key metrics

## Exporting Reports

### CSV Export

```dart
String _generateCSV(SalesSummaryReport report) {
  final buffer = StringBuffer();
  buffer.writeln('Metric,Value');
  buffer.writeln('Total Revenue,\$${report.wonRevenue}');
  buffer.writeln('Total Deals,${report.totalDeals}');
  buffer.writeln('Won Deals,${report.wonDeals}');
  buffer.writeln('Conversion Rate,${report.conversionRate}%');
  return buffer.toString();
}
```

### PDF Export

For PDF generation, consider using:
- `pdf` package for Flutter
- `printing` package for cross-platform support
- Custom templates for branded reports

## Future Enhancements

- [ ] Charts and graphs (using `fl_chart`)
- [ ] Custom report builder
- [ ] Scheduled reports (email/PDF)
- [ ] Comparative reports (YoY, QoQ)
- [ ] Drill-down analytics
- [ ] Team performance comparisons
- [ ] Mobile optimization
- [ ] Offline report caching
- [ ] Advanced filters
- [ ] Data export (CSV, Excel, PDF)

## Troubleshooting

### Common Issues

1. **Slow Report Generation**
   - Check database indexes
   - Optimize queries
   - Add date range limits

2. **Incorrect Calculations**
   - Verify date handling
   - Check null values
   - Review business logic

3. **UI Performance Issues**
   - Use lazy loading
   - Cache report data
   - Optimize rebuilds

### Debugging

Enable logging:

```dart
// Enable debug mode in Supabase
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  debug: true,
);
```

## Conclusion

The CRM sales reports system provides comprehensive analytics for tracking sales performance, pipeline health, and team productivity. The real-time data and flexible date ranges make it suitable for daily operations as well as strategic planning.

For more information, refer to:
- [Supabase SQL Reference](https://supabase.com/docs/reference/sql)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Material Design - Data Display](https://material.io/design/communication/data-visualization.html)
