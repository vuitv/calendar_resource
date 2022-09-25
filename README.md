# Calendar Horizontal Resource

![flutter_version][flutter_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A package calendar making by Vido Team

---

# Preview

<img src="https://raw.github.com/vuitv/calendar_resource/assets/preview.png">

# Install

Then import it to your project:

`import 'package:calendar_resource/calendar.dart';`

# Usage Calendar Widget

Add CalendarBloc:

```
    BlocProvider(
       create: (_) => CalendarBloc(),
       child: ...
    )
```

Use Calendar Widget:

```
    Calendar(
        theme: CalendarTheme.light(
            todayHighlightColor: Theme.of(context).primaryColor,
        ),
    )
```

[flutter_badge]: https://img.shields.io/badge/flutter-v3.0.5-blue

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_link]: https://opensource.org/licenses/MIT

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg

[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
