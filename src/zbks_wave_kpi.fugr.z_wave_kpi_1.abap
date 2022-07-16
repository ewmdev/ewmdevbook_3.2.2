FUNCTION z_wave_kpi_1.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_LGNUM) TYPE  /SCWM/LGNUM
*"     REFERENCE(IV_VARIANT) TYPE  VARIANT
*"     REFERENCE(IV_REPID) TYPE  /SCWM/DE_MS_REPID
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  /SCWM/DE_MS_RESULT
*"     REFERENCE(EV_UNIT) TYPE  /SCWM/DE_UNIT
*"  EXCEPTIONS
*"      ERROR
*"----------------------------------------------------------------------

  DATA: lt_data TYPE /scwm/tt_wavehdr_det_mon_out,
        lv_rc   TYPE sysubrc.

  "1.Check the existence of the variant
  CALL FUNCTION 'RS_VARIANT_EXISTS'
    EXPORTING
      report  = iv_repid
      variant = iv_variant
    IMPORTING
      r_c     = lv_rc
    EXCEPTIONS
      OTHERS  = 99.
  IF lv_rc NE 0 OR sy-subrc NE 0.
    RAISE error.
  ENDIF.
  "2.Call the monitor selection with selscreen IV_Variant
  CALL FUNCTION '/SCWM/WAVEHDR_O_MON'
    EXPORTING
      iv_lgnum      = iv_lgnum
      iv_variant    = iv_variant
      iv_mode       = '2'
    IMPORTING
      et_data       = lt_data
    EXCEPTIONS
      error_message = 99.
  IF sy-subrc NE 0.
    RAISE error.
  ENDIF.
  "3.Summarize the number of items in the wave
  LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
    ev_result = ev_result + <ls_data>-noitm.
  ENDLOOP.

ENDFUNCTION.
