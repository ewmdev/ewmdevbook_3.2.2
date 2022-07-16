FUNCTION z_bks_wave_selscreen.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_DYNNR) TYPE  DYNNR
*"  CHANGING
*"     REFERENCE(CV_VARIANT) TYPE  VARIANT
*"----------------------------------------------------------------------
  DATA: lv_lgnum TYPE /scwm/lgnum.
  "Provide the hidden WH field for the WH MON screens
  GET PARAMETER ID '/SCWM/LGN' FIELD lv_lgnum.
  CALL FUNCTION '/SCWM/WAVEHDR_MON'
    EXPORTING
      iv_lgnum   = lv_lgnum
      iv_variant = cv_variant
    IMPORTING
      ev_variant = cv_variant.
  "Return current variant
  cv_variant = sy-slset.

ENDFUNCTION.
