// date = Array - date in format [year, month, day, hour, minute], where:
_monthNum = date select 1;
_monthStr = "";

switch (_monthNum) do
{
    case 1: { _monthStr = "Jan" };
    case 2: { _monthStr = "Feb" };
    case 3: { _monthStr = "Mar" };
    case 4: { _monthStr = "Apr" };
    case 5: { _monthStr = "May" };
    case 6: { _monthStr = "Jun" };
    case 7: { _monthStr = "Jul" };
    case 8: { _monthStr = "Aug" };
    case 9: { _monthStr = "Sep" };
    case 10: { _monthStr = "Oct" };
    case 11: { _monthStr = "Nov" };
    case 12: { _monthStr = "Dec" };
    default {_monthStr = ""};
};

_monthStr
