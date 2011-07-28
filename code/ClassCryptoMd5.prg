
DEFINE CLASS ClassCryptoMd5 AS ClassCustom

	FUNCTION Encode
		LPARAMETERS lcText
		LOCAL lcOutput
		lcOutput = ""
		RETURN lcOutput
	ENDFUNC
ENDDEF

&& ==========================================================================
&& url: http://fox.wikis.com/wc.dll?Wiki~VfpMd5HashFunction#win32
&& date: Sun, 06 Jun 2010 12:45:51 +0700
&& dependency: WinNT4, Win95OSR2+ or Win95 & IE3.02+
&& ------------------------------------------------------------------------
&& 	
&& #include "c:\program files\microsoft [[Visual FoxPro]] 8\ffc\wincrypt.h"
&& 
&& * This routine takes a string as input
&& * and returns an MD5 hash value as a string.
&& *
&& * The calculation in implemented using the MS Crypto API and the RSA provider.
&& 
&& 
&& FUNCTION HashMD5(tcData)
&& 
&&   LOCAL lnStatus, lnErr, lhProv, lhHashObject, lnDataSize, lcHashValue, lnHashSize
&&   lhProv = 0
&&   lhHashObject = 0
&&   lnDataSize = LEN(tcData)
&&   lcHashValue = REPLICATE(CHR(0), 16)
&&   lnHashSize = LEN(lcHashValue)
&& 
&& 
&&   TRY
&& 
&&     DECLARE INTEGER GetLastError ;
&&       IN win32api AS GetLastError
&& 
&&     DECLARE INTEGER CryptAcquireContextA ;
&&       IN WIN32API AS CryptAcquireContext ;
&&       INTEGER @lhProvHandle, ;
&&       STRING  cContainer, ;
&&       STRING  cProvider, ;
&&       INTEGER nProvType, ;
&&       INTEGER nFlags
&& 
&&     * load a crypto provider
&&     lnStatus = CryptAcquireContext(@lhProv, 0, 0, dnPROV_RSA_FULL, dnCRYPT_VERIFYCONTEXT)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&&     DECLARE INTEGER CryptCreateHash ;
&&       IN WIN32API AS CryptCreateHash ;
&&       INTEGER hProviderHandle, ;
&&       INTEGER nALG_ID, ;
&&       INTEGER hKeyhandle, ;
&&       INTEGER nFlags, ;
&&       INTEGER @hCryptHashHandle
&& 
&&     * create a hash object that uses MD5 algorithm
&&     lnStatus = CryptCreateHash(lhProv, dnCALG_MD5, 0, 0, @lhHashObject)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&& 
&&     DECLARE INTEGER CryptHashData ;
&&       IN WIN32API AS CryptHashData ;
&&       INTEGER hHashHandle, ;
&&       STRING  @cData, ;
&&       INTEGER nDataLen, ;
&&       INTEGER nFlags
&& 
&&     * add the input data to the hash object
&&     lnStatus = CryptHashData(lhHashObject, tcData, lnDataSize, 0)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&& 
&&     DECLARE INTEGER CryptGetHashParam ;
&&       IN WIN32API AS CryptGetHashParam ;
&&       INTEGER hHashHandle, ;
&&       INTEGER nParam, ;
&&       STRING  @cHashValue, ;
&&       INTEGER @nHashSize, ;
&&       INTEGER nFlags
&& 
&&     * retrieve the hash value, if caller did not provide enough storage (16 bytes for MD5)
&&     * this will fail with dnERROR_MORE_DATA and lnHashSize will contain needed storage size
&&     lnStatus = CryptGetHashParam(lhHashObject, dnHP_HASHVAL, @lcHashValue, @lnHashSize, 0)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&& 
&&     DECLARE INTEGER CryptDestroyHash ;
&&       IN WIN32API AS CryptDestroyHash;
&&       INTEGER hKeyHandle
&& 
&&     * free the hash object
&&     lnStatus = CryptDestroyHash(lhHashObject)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&& 
&&     DECLARE INTEGER CryptReleaseContext ;
&&       IN WIN32API AS CryptReleaseContext ;
&&       INTEGER hProvHandle, ;
&&       INTEGER nReserved
&& 
&&     * release the crypto provider
&&     lnStatus = CryptReleaseContext(lhProv, 0)
&&     IF lnStatus = 0
&&       THROW GetLastError()
&&     ENDIF
&& 
&&   CATCH TO lnErr
&& 
&&     * clean up the hash object and release provider
&&     IF lhHashObject != 0
&&       CryptDestroyHash(lhHashObject)
&&     ENDIF
&& 
&& 
&&     IF lhProv != 0
&&       CryptReleaseContext(lhProv, 0)
&&     ENDIF
&& 
&&     ERROR("HashMD5 Failed")
&& 
&&   ENDTRY
&& 
&&   RETURN lcHashValue
&& 
&& ENDFUNC
&& ==========================================================================
