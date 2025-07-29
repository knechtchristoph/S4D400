@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true

define root view entity ZCK_C_AgencyTP
  provider contract transactional_query
  as projection on /DMO/R_AgencyTP
{
  key AgencyID,
      Name,
      Street,
      PostalCode,
      City,
      CountryCode,
      PhoneNumber,
      EMailAddress,
      WebAddress,
      Attachment,
      MimeType,
      Filename,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /DMO/ZZSloganZAG,
      /* Associations */
      //      /DMO/ZZ_ReviewAvgZAG,
      //      /DMO/ZZ_ReviewZAG,
      _Country
}
