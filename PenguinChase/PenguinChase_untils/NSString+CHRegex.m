//
//  NSString+CHRegex.m
//  SY全民共进
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 gch. All rights reserved.
//

#import "NSString+CHRegex.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CHRegex)
- (BOOL)isValidateWithRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

/* 邮箱验证 MODIFIED BY HELENSONG */
- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/* 手机号码验证 MODIFIED BY HELENSONG */
- (BOOL)isValidPhoneNum
{
    //    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0,0-9])|(19[0-9]))\\d{8}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:self];
    
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
    
    
}
/** 手机号中间四位用****显示*/
+ (NSString *)numberPhoneSuitScanf:(NSString *)phone  strRange:(NSRange)strRange{
    //首先验证是不是手机号码
    BOOL isOk = [phone isValidPhoneNum];
    if (isOk) {
        NSInteger len = strRange.length;
        NSMutableString *lenstring = [[NSMutableString alloc] init];
        for (int i = 0; i < len; i++) {
            [lenstring appendString:@"*"];
        }
        //如果是手机号码的话
        NSString *numberString = [phone stringByReplacingCharactersInRange:strRange withString:lenstring.copy];
        return numberString;
    }
    return phone;
}
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght

{

    NSString *newStr = originalStr;

    for (int i = 0; i < lenght; i++) {

        NSRange range = NSMakeRange(startLocation, 1);

        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];

        startLocation ++;

    }

    return newStr;

}

/* 车牌号验证 MODIFIED BY HELENSONG */
- (BOOL)isValidCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

/** 网址验证 */
- (BOOL)isValidUrl
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateWithRegex:regex];
}

/** 邮政编码 */
- (BOOL)isValidPostalcode {
    NSString *phoneRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/** 纯汉字 */
- (BOOL)isValidChinese;
{
    NSString *phoneRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/** MD5加密 */
- (NSString *)MD5String
{
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)isValidIP;
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}

/** 身份证验证 refer to http://blog.csdn.net/afyzgh/article/details/16965107 */
- (BOOL)isValidIdCardNum
{
    NSString *value = [self copy];
    value = [value stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"                   options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"           options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
                
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19|20[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
    }
    return NO;
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    //  [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}
- (NSString *)stringReplacing {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (NSString *)chStringByReplacingOfString:(NSString *)ofString withString:(NSString *)wString {
    return [self stringByReplacingOccurrencesOfString:ofString withString:wString];
}

/** 去掉html格式 */
- (NSString *)removeHtmlFormat;
{
    NSString *str = [NSString stringWithFormat:@"%@", self];
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        str = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@"$2$1"];
    } else {
        NSLog(@"%@", error);
    }
    
    NSArray *html_code = @[
                           @"\"", @"'", @"&", @"<", @">",
                           @"", @"¡", @"¢", @"£", @"¤",
                           @"¥", @"¦", @"§", @"¨", @"©",
                           @"ª", @"«", @"¬", @"", @"®",
                           @"¯", @"°", @"±", @"²", @"³",
                           
                           @"´", @"µ", @"¶", @"·", @"¸",
                           @"¹", @"º", @"»", @"¼", @"½",
                           @"¾", @"¿", @"×", @"÷", @"À",
                           @"Á", @"Â", @"Ã", @"Ä", @"Å",
                           @"Æ", @"Ç", @"È", @"É", @"Ê",
                           
                           @"Ë", @"Ì", @"Í", @"Î", @"Ï",
                           @"Ð", @"Ñ", @"Ò", @"Ó", @"Ô",
                           @"Õ", @"Ö", @"Ø", @"Ù", @"Ú",
                           @"Û", @"Ü", @"Ý", @"Þ", @"ß",
                           @"à", @"á", @"â", @"ã", @"ä",
                           
                           @"å", @"æ", @"ç", @"è", @"é",
                           @"ê", @"ë", @"ì", @"í", @"î",
                           @"ï", @"ð", @"ñ", @"ò", @"ó",
                           @"ô", @"õ", @"ö", @"ø", @"ù",
                           @"ú", @"û", @"ü", @"ý", @"þ",
                           
                           @"ÿ", @"∀", @"∂", @"∃", @"∅",
                           @"∇", @"∈", @"∉", @"∋", @"∏",
                           @"∑", @"−", @"∗", @"√", @"∝",
                           @"∞", @"∠", @"∧", @"∨", @"∩",
                           @"∪", @"∫", @"∴", @"∼", @"≅",
                           
                           @"≈", @"≠", @"≡", @"≤", @"≥",
                           @"⊂", @"⊃", @"⊄", @"⊆", @"⊇",
                           @"⊕", @"⊗", @"⊥", @"⋅", @"Α",
                           @"Β", @"Γ", @"Δ", @"Ε", @"Ζ",
                           @"Η", @"Θ", @"Ι", @"Κ", @"Λ",
                           
                           @"Μ", @"Ν", @"Ξ", @"Ο", @"Π",
                           @"Ρ", @"Σ", @"Τ", @"Υ", @"Φ",
                           @"Χ", @"Ψ", @"Ω", @"α", @"β",
                           @"γ", @"δ", @"ε", @"ζ", @"η",
                           @"θ", @"ι", @"κ", @"λ", @"μ",
                           
                           @"ν", @"ξ", @"ο", @"π", @"ρ",
                           @"ς", @"σ", @"τ", @"υ", @"φ",
                           @"χ", @"ψ", @"ω", @"ϑ", @"ϒ",
                           @"ϖ", @"Œ", @"œ", @"Š", @"š",
                           @"Ÿ", @"ƒ", @"ˆ", @"˜", @"",
                           
                           @"", @"", @"", @"", @"",
                           @"", @"–", @"—", @"‘", @"’",
                           @"‚", @"“", @"”", @"„", @"†",
                           @"‡", @"•", @"…", @"‰", @"′",
                           @"″", @"‹", @"›", @"‾", @"€",
                           
                           @"™", @"←", @"↑", @"→", @"↓",
                           @"↔", @"↵", @"⌈", @"⌉", @"⌊",
                           @"⌋", @"◊", @"♠", @"♣", @"♥",
                           @"♦",
                           ];
    NSArray *code = @[
                      @"&quot;", @"&apos;", @"&amp;", @"&lt;", @"&gt;",
                      @"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;",
                      @"&yen;", @"&brvbar;", @"&sect;", @"&uml;", @"&copy;",
                      @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
                      @"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;",
                      
                      @"&acute;", @"&micro;", @"&para;", @"&middot;", @"&cedil;",
                      @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;", @"&frac12;",
                      @"&frac34;", @"&iquest;", @"&times;", @"&divide;", @"&Agrave;",
                      @"&Aacute;", @"&Acirc;", @"&Atilde;", @"&Auml;", @"&Aring;",
                      @"&AElig;", @"&Ccedil;", @"&Egrave;", @"&Eacute;", @"&Ecirc;",
                      
                      @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
                      @"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;",
                      @"&Otilde;", @"&Ouml;", @"&Oslash;", @"&Ugrave;", @"&Uacute;",
                      @"&Ucirc;", @"&Uuml;", @"&Yacute;", @"&THORN;", @"&szlig;",
                      @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
                      
                      @"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;",
                      @"&ecirc;", @"&euml;", @"&igrave;", @"&iacute;", @"&icirc;",
                      @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;", @"&oacute;",
                      @"&ocirc;", @"&otilde;", @"&ouml;", @"&oslash;", @"&ugrave;",
                      @"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;",
                      
                      @"&yuml;", @"&forall;", @"&part;", @"&exists;", @"&empty;",
                      @"&nabla;", @"&isin;", @"&notin;", @"&ni;", @"&prod;",
                      @"&sum;", @"&minus;", @"&lowast;", @"&radic;", @"&prop;",
                      @"&infin;", @"&ang;", @"&and;", @"&or;", @"&cap;",
                      @"&cup;", @"&int;", @"&there4;", @"&sim;", @"&cong;",
                      
                      @"&asymp;", @"&ne;", @"&equiv;", @"&le;", @"&ge;",
                      @"&sub;", @"&sup;", @"&nsub;", @"&sube;", @"&supe;",
                      @"&oplus;", @"&otimes;", @"&perp;", @"&sdot;", @"&Alpha;",
                      @"&Beta;", @"&Gamma;", @"&Delta;", @"&Epsilon;", @"&Zeta;",
                      @"&Eta;", @"&Theta;", @"&Iota;", @"&Kappa;", @"&Lambda;",
                      
                      @"&Mu;", @"&Nu;", @"&Xi;", @"&Omicron;", @"&Pi;",
                      @"&Rho;", @"&Sigma;", @"&Tau;", @"&Upsilon;", @"&Phi;",
                      @"&Chi;", @"&Psi;", @"&Omega;", @"&alpha;", @"&beta;",
                      @"&gamma;", @"&delta;", @"&epsilon;", @"&zeta;", @"&eta;",
                      @"&theta;", @"&iota;", @"&kappa;", @"&lambda;", @"&mu;",
                      
                      @"&nu;", @"&xi;", @"&omicron;", @"&pi;", @"&rho;",
                      @"&sigmaf;", @"&sigma;", @"&tau;", @"&upsilon;", @"&phi;",
                      @"&chi;", @"&psi;", @"&omega;", @"&thetasym;", @"&upsih;",
                      @"&piv;", @"&OElig;", @"&oelig;", @"&Scaron;", @"&scaron;",
                      @"&Yuml;", @"&fnof;", @"&circ;", @"&tilde;", @"&ensp;",
                      
                      @"&emsp;", @"&thinsp;", @"&zwnj;", @"&zwj;", @"&lrm;",
                      @"&rlm;", @"&ndash;", @"&mdash;", @"&lsquo;", @"&rsquo;",
                      @"&sbquo;", @"&ldquo;", @"&rdquo;", @"&bdquo;", @"&dagger;",
                      @"&Dagger;", @"&bull;", @"&hellip;", @"&permil;", @"&prime;",
                      @"&Prime;", @"&lsaquo;", @"&rsaquo;", @"&oline;", @"&euro;",
                      
                      @"&trade;", @"&larr;", @"&uarr;", @"&rarr;", @"&darr;",
                      @"&harr;", @"&crarr;", @"&lceil;", @"&rceil;", @"&lfloor;",
                      @"&rfloor;", @"&loz;", @"&spades;", @"&clubs;", @"&hearts;",
                      @"&diams;",
                      ];
    //    NSArray *code_hex = @[
    //                          @"&#34;", @"&#39;", @"&#38;", @"&#60;", @"&#62;",
    //                          @"&#160;", @"&#161;", @"&#162;", @"&#163;", @"&#164;",
    //                          @"&#165;", @"&#166;", @"&#167;", @"&#168;", @"&#169;",
    //                          @"&#170;", @"&#171;", @"&#172;", @"&#173;", @"&#174;",
    //                          @"&#175;", @"&#176;", @"&#177;", @"&#178;", @"&#179;",
    //
    //                          @"&#180;", @"&#181;", @"&#182;", @"&#183;", @"&#184;",
    //                          @"&#185;", @"&#186;", @"&#187;", @"&#188;", @"&#189;",
    //                          @"&#190;", @"&#191;", @"&#215;", @"&#247;", @"&#192;",
    //                          @"&#193;", @"&#194;", @"&#195;", @"&#196;", @"&#197;",
    //                          @"&#198;", @"&#199;", @"&#200;", @"&#201;", @"&#202;",
    //
    //                          @"&#203;", @"&#204;", @"&#205;", @"&#206;", @"&#207;",
    //                          @"&#208;", @"&#209;", @"&#210;", @"&#211;", @"&#212;",
    //                          @"&#213;", @"&#214;", @"&#216;", @"&#217;", @"&#218;",
    //                          @"&#219;", @"&#220;", @"&#221;", @"&#222;", @"&#223;",
    //                          @"&#224;", @"&#225;", @"&#226;", @"&#227;", @"&#228;",
    //
    //                          @"&#229;", @"&#230;", @"&#231;", @"&#232;", @"&#233;",
    //                          @"&#234;", @"&#235;", @"&#236;", @"&#237;", @"&#238;",
    //                          @"&#239;", @"&#240;", @"&#241;", @"&#242;", @"&#243;",
    //                          @"&#244;", @"&#245;", @"&#246;", @"&#248;", @"&#249;",
    //                          @"&#250;", @"&#251;", @"&#252;", @"&#253;", @"&#254;",
    //
    //                          @"&#255;", @"&#8704;", @"&#8706;", @"&#8707;", @"&#8709;",
    //                          @"&#8711;", @"&#8712;", @"&#8713;", @"&#8715;", @"&#8719;",
    //                          @"&#8721;", @"&#8722;", @"&#8727;", @"&#8730;", @"&#8733;",
    //                          @"&#8734;", @"&#8736;", @"&#8743;", @"&#8744;", @"&#8745;",
    //                          @"&#8746;", @"&#8747;", @"&#8756;", @"&#8764;", @"&#8773;",
    //
    //                          @"&#8776;", @"&#8800;", @"&#8801;", @"&#8804;", @"&#8805;",
    //                          @"&#8834;", @"&#8835;", @"&#8836;", @"&#8838;", @"&#8839;",
    //                          @"&#8853;", @"&#8855;", @"&#8869;", @"&#8901;", @"&#913;",
    //                          @"&#914;", @"&#915;", @"&#916;", @"&#917;", @"&#918;",
    //                          @"&#919;", @"&#920;", @"&#921;", @"&#922;", @"&#923;",
    //
    //                          @"&#924;", @"&#925;", @"&#926;", @"&#927;", @"&#928;",
    //                          @"&#929;", @"&#931;", @"&#932;", @"&#933;", @"&#934;",
    //                          @"&#935;", @"&#936;", @"&#937;", @"&#945;", @"&#946;",
    //                          @"&#947;", @"&#948;", @"&#949;", @"&#950;", @"&#951;",
    //                          @"&#952;", @"&#953;", @"&#954;", @"&#923;", @"&#956;",
    //
    //                          @"&#925;", @"&#958;", @"&#959;", @"&#960;", @"&#961;",
    //                          @"&#962;", @"&#963;", @"&#964;", @"&#965;", @"&#966;",
    //                          @"&#967;", @"&#968;", @"&#969;", @"&#977;", @"&#978;",
    //                          @"&#982;", @"&#338;", @"&#339;", @"&#352;", @"&#353;",
    //                          @"&#376;", @"&#402;", @"&#710;", @"&#732;", @"&#8194;",
    //
    //                          @"&#8195;", @"&#8201;", @"&#8204;", @"&#8205;", @"&#8206;",
    //                          @"&#8207;", @"&#8211;", @"&#8212;", @"&#8216;", @"&#8217;",
    //                          @"&#8218;", @"&#8220;", @"&#8221;", @"&#8222;", @"&#8224;",
    //                          @"&#8225;", @"&#8226;", @"&#8230;", @"&#8240;", @"&#8242;",
    //                          @"&#8243;", @"&#8249;", @"&#8250;", @"&#8254;", @"&#8364;",
    //
    //                          @"&#8482;", @"&#8592;", @"&#8593;", @"&#8594;", @"&#8595;",
    //                          @"&#8596;", @"&#8629;", @"&#8968;", @"&#8969;", @"&#8970;",
    //                          @"&#8971;", @"&#9674;", @"&#9824;", @"&#9827;", @"&#9829;",
    //                          @"&#9830;",
    //                          ];
    //
    NSInteger idx = 0;
    for (NSString *obj in code) {
        str = [str stringByReplacingOccurrencesOfString:(NSString *)obj withString:html_code[idx]];
        idx++;
    }
    return str;
}

/** 判断是否是空字符串 */
+ (BOOL) isBlankString:(NSString *)str
{
    if ([str isEqual:@"NULL"] || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqual:NULL] || [[str class] isSubclassOfClass:[NSNull class]] || str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"nil"]  || [str isEqualToString:@""] || str.length == 0 || !str) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)stringConcatentationRobot:(NSString *)str {
    NSString *htmlUrl = [NSString stringWithFormat:@"%@", str];
    if ([htmlUrl rangeOfString:@"?"].location == NSNotFound ) {
        htmlUrl = [NSString stringWithFormat:@"%@?robot=%@", str, [NSString randomStringWithLength:8]];
    } else {
        htmlUrl = [NSString stringWithFormat:@"%@&robot=%@", str, [NSString randomStringWithLength:8]];
    }
    return htmlUrl;
}

/** json字符串转对象 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)string {
    if ([NSString isBlankString:string] == YES) {
        return nil;
    }

    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/** json字符串转数组*/
+ (NSArray *)stringJsonToArray:(NSString *)string {
    if (string) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                return tmp;
            } else if([tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSDictionary class]]) {
                return [NSArray arrayWithObject:tmp];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

+ (NSString *)dictionaryTurnJsonString:(NSDictionary *)dictionary {
    NSError *error;
    if (dictionary) {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    }
    return nil;
    
}

+ (NSString *)arrayTurnJsonString:(NSArray *)array {
    NSError *error;
    if (array) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        if (!jsonData) {
            NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        
        return mutStr;
    }
    return nil;
}

/** 工商税号 */
- (BOOL)isValidTaxNo
{
    NSString *emailRegex = @"[0-9]\\d{13}([0-9]|X)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 取消字符串中的空格换行符*/
- (NSString *)noWhiteSpaceString {
//    NSString *newString = self;
//    //去除掉首尾的空白字符和换行字符
//    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    newString = [newString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//    newString = [newString stringByReplacingOccurrencesOfString:@"<\br>" withString:@""];
//    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
//    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    //  过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:self];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        
        //  在这里添加要过滤的特殊符号
        if (c == '\n' || c == '\r' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            if (c == '\n') {
                // 解决后台返回的字段中带有/r,/t但不能换行的问题
                [str1 insertString:@"</br>" atIndex:i];
            }
            
            --i;
        }
    }
    return str1;
}


#pragma mark ---width or height
// 获取Label宽
- (CGSize)getStringWidthIncomingHeight:(CGFloat)textHeight fontSize:(CGFloat)font fontName:(NSString *)fontName textColor:(UIColor *)textColor
{
    
    //    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    //    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    UIFont *newfont;
    if ([NSString isBlankString:fontName]) {
        newfont = [UIFont systemFontOfSize:font];
    } else {
        newfont = [UIFont fontWithName:fontName size:font];
    }
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                NSForegroundColorAttributeName:textColor,
                                                                                                                                         NSFontAttributeName:newfont
                                                                                                                                         } context:nil].size;
    //返回计算出的行高
    return textSize;
}
// 获取Label高
- (CGSize)getStringHeightIncomingWidth:(CGFloat)textWidth fontSize:(CGFloat)font fontName:(NSString *)fontName textColor:(UIColor *)textColor
{
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
//
//
//    CGSize textSize = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    
//    UIFont *font=[UIFont boldSystemFontOfSize:13.0];
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading attributes:@{
                                                                                                                            
                                       NSForegroundColorAttributeName:textColor,                                                                                                 NSFontAttributeName:[UIFont fontWithName:fontName size:font]
                                                                                                                                        } context:nil].size;
    //返回计算出的行高
    return textSize;
}
- (CGSize)cxl_sizeWithString:(UIFont *)font
{
    if(self.length)
    {
    NSDictionary *dic = @{NSFontAttributeName : font};
    return [self sizeWithAttributes:dic];
    }else{
        return CGSizeZero;
    }
}
- (CGRect)cxl_sizeWithMoreString:(UIFont *)font maxWidth:(CGFloat)width
{
    NSDictionary *dic = @{NSFontAttributeName : font};
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return  [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
}
// 签名算法
- (NSString *)getUrlEncode {
    if ([NSString isBlankString:self] == YES) {
        return @"";
    }
    NSString *md5 = [self MD5String];
    NSString *returnString = @"a";
    for (int i = 1; i < 6; i++) {
        int a = (int)pow(2, i) - 1; // pow(2, n) 2的n次方
        NSString *child = [md5 substringWithRange:NSMakeRange(a, 1)];
        returnString = [NSString stringWithFormat:@"%@%@", returnString, child];
    }
    return [returnString substringFromIndex:1];
}

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString {
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}
// URLEncode转码
- (NSString *)URLEncodedString {
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}
// 字符串转utf-8
- (NSString *)stringUTF8 {
  return  [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
// utf-8转字符串
- (NSString *)utf8String {
    return [self stringByRemovingPercentEncoding];
}

// 转换为Base64编码
- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

// 将Base64编码还原
- (NSString *)base64DecodedString {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

static NSDateFormatter *dateFormatter = nil;
+ (NSDateFormatter *)cachedDateFormatter {
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    return dateFormatter;
}

// 获取当前时间
+ (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
//    [dateFormatter setDateFormat:@"yyyy:MM:dd hh:mm:ss SS "];//设定时间格式,这里可以设置成自己需要的格式
    dateFormatter = [NSString cachedDateFormatter];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

// 获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr{
    NSTimeInterval time=[self doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter = [NSString cachedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒, 没有hh-mm-ss
- (NSString *)getDateStringWithTimeStrNOHMS{
    NSTimeInterval time=[self doubleValue]/1000;// 传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // 实例化一个NSDateFormatter对象
    // 设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

// 字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 设定时间的格式
    dateFormatter = [NSString cachedDateFormatter];
    NSDate *tempDate = [dateFormatter dateFromString:self];// 将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];// 字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}
// 将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString {
    NSTimeInterval time=[dateString doubleValue]/1000;
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    dateFormatter = [NSString cachedDateFormatter];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    NSDate *destDate= [dateFormatter dateFromString:currentDateStr];
    return destDate;
}


//传入今天的时间，返回明天的时间
+ (NSString *)getTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+7)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
//    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
//    [dateday setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter = [NSString cachedDateFormatter];
    NSString *result = [[dateFormatter stringFromDate:beginningOfWeek] getTimeStrWithString];
    return result;
}



#pragma mark -- 随机生成指定位数字符串
+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        NSInteger arcInter = (NSInteger)arc4random_uniform((int)letters.length);
        [randomString appendFormat: @"%C", [letters characterAtIndex: arcInter]];
    }
    return randomString;
}

+ (NSString *)getCurrentDeviceUUID {
    NSUUID *indentifierForVendor = [[UIDevice currentDevice] identifierForVendor];
    NSString *temp = [NSString stringWithFormat:@"%@", indentifierForVendor];
    return temp;
}
#pragma mark -- 字符串是否包含某些字符
+ (BOOL)stringDoesitIncludeString:(NSString *)string containsString:(NSString *)str {
    if ([string rangeOfString:string].location !=NSNotFound) {
        return YES;
    }
    return NO;
}
// 根据正则，过滤特殊字符, 只有中文
+ (NSString *)filterCharactor:(NSString *)string Addition:(NSString *)addString{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:addString options:NSRegularExpressionCaseInsensitive error:&error]; // [^\u4e00-\u9fa5]
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}
+ (NSMutableAttributedString *)getChiesMutableAttributedString:(NSString *)str {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attString removeAttribute:NSParagraphStyleAttributeName range:NSMakeRange(0, attString.length)];
    //    // 行间距
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.lineSpacing = 3;// 字体的行间距
    //    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attString length])];
    return attString;
}



@end
