#
# See `docs.md` for package documentation.
#
{
    stdenv, fetchFromGitHub
}:
let
  vendor = fetchFromGitHub {                                   # (1)
    owner = "Martel-IT";
    repo = "odoo16.box";
    rev = "vendor-addons-04-Mar-2025";
    sha256 = "sha256-odoo16box=";
  };
  
  hr-timesheet-overtime = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_hr_timesheet_overtime";
    rev = "Latest";          # (2)
    sha256 = "sha256-hrovertime=";
  };
  timesheets-by-employee = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_timesheets_by_employee";
    rev = "Latest";          # (2)
    sha256 = "sha256-timesheetsbyemplpoyee=";
  };
  download-attachments = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_download_attachments";
    rev = "Latest";          # (2)
    sha256 = "sha256-downloadattachmentsAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  hr-expense = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_hr_expense";
    rev = "Latest";          # (2)
    sha256 = "sha256-hrexpenseAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  custom-menu-style = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_menu_style";
    rev = "Latest";          # (2)
    sha256 = "sha256-menustyleAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  timesheet-sheet-fullwidth = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_timesheet_sheet_fullwidth";
    rev = "v1.0";          # (2)
    sha256 = "sha256-fullwidthAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  custom-expense-limit = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_expense_limit";
    rev = "latest";          # (2)
    sha256 = "sha256-expenselimitAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  custom-web = fetchFromGitHub {
    owner = "Martel-IT";
    repo = "custom_web";
    rev = "latest";          # (2)
    sha256 = "sha256-customwebAAAAAAAAAAAAA=";
  };
in stdenv.mkDerivation rec {
    pname = "odoo-addons";
    version = "1.0.0-odoo-16.0";

    src = vendor;
    src-hr-timesheet-overtime = hr-timesheet-overtime;
    src-timesheets-by-employee = timesheets-by-employee;
    src-download-attachments = download-attachments;
    src-hr-expense = hr-expense;
    src-custom-menu-style = custom-menu-style;
    src-timesheet-sheet-fullwidth = timesheet-sheet-fullwidth;
    src-custom-expense-limit = custom-expense-limit;
    src-custom-web = custom-web;

    installPhase = ''
      mkdir -p $out/hr_timesheet_overtime
      cp -rv ${src-hr-timesheet-overtime}/. $out/hr_timesheet_overtime

      mkdir -p $out/timesheets_by_employee
      cp -rv ${src-timesheets-by-employee}/. $out/timesheets_by_employee

      mkdir -p $out/download-attachments
      cp -rv ${src-download-attachments}/. $out/download-attachments

      mkdir -p $out/hr-expense
      cp -rv ${src-hr-expense}/. $out/hr-expense

      mkdir -p $out/custom-menu-style
      cp -rv ${src-custom-menu-style}/. $out/custom-menu-style

      mkdir -p $out/timesheet-sheet-fullwidth
      cp -rv ${src-timesheet-sheet-fullwidth}/. $out/timesheet-sheet-fullwidth

      mkdir -p $out/custom-expense-limit
      cp -rv ${src-custom-expense-limit}/. $out/custom-expense-limit

      mkdir -p $out/web
      cp -rv ${src-custom-web}/. $out/web

      cp -rv $src/vendor/addons/* $out
    '';
}
# NOTE
# ----
# 1. Vendor addons. At the moment the sources for the various vendor
# addons installed in Martel's prod Odoo are in this repo after being
# copied over from prod. This is not the way to go, but rather a stop
# gap solution. See #2.
# 2. Release tags. Ideally we'd use release tags instead of revs. But
# at the moment hr-timesheet-overtime and timesheets-by-employee don't
# have a release process in place.
#