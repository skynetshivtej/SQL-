select * [ININ_DIALER_40].[CallHistory] ch
left outer join [ININ_DIALER_40].[WrapupCode] wco on ch.wrapupcode=wco.Id
left outer join [ININ_DIALER_40].[WrapupCategory] wca on ch.wrapupcategory=wca.Id
