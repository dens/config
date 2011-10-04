#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <errno.h>

static const char* errconstant_from_num (int errnum);
static int         errconstant_to_num (const char* what);

int
main (int argc, char** argv)
{
  if (argc == 2 && argv[1][0] != '-')
    {
      int errnum = atoi (argv[1]);
      const char* constant;
      printf ("%s\n", strerror (errnum));
      if ((constant = errconstant_from_num (errnum)))
        printf ("%s\n", constant);
    }
  else if (argc == 3 && strcmp (argv[1], "-r") == 0)
    {
      int errnum = errconstant_to_num (argv[2]);
      printf ("%i\n", errnum);
    }
  else
    {
      fprintf (stderr,
               "usage: %s ERRNUM\n"
               "       %s -r ERRCONSTANT\n",
               argv[0], argv[0]);
      return 1;
    }
  return 0;
}

static const char*
errconstant_from_num (int errnum)
{
#define C(S) case S: return #S
  switch (errnum)
    {
      C (EPERM);
      C (ENOENT);
      C (ESRCH);
      C (EINTR);
      C (EIO);
      C (ENXIO);
      C (E2BIG);
      C (ENOEXEC);
      C (EBADF);
      C (ECHILD);
    case EAGAIN: return "EAGAIN, EWOULDBLOCK";
      C (ENOMEM);
      C (EACCES);
      C (EFAULT);
      C (ENOTBLK);
      C (EBUSY);
      C (EEXIST);
      C (EXDEV);
      C (ENODEV);
      C (ENOTDIR);
      C (EISDIR);
      C (EINVAL);
      C (ENFILE);
      C (EMFILE);
      C (ENOTTY);
      C (ETXTBSY);
      C (EFBIG);
      C (ENOSPC);
      C (ESPIPE);
      C (EROFS);
      C (EMLINK);
      C (EPIPE);
      C (EDOM);
      C (ERANGE);
    case EDEADLK: return "EDEADLK, EDEADLOCK";
      C (ENAMETOOLONG);
      C (ENOLCK);
      C (ENOSYS);
      C (ENOTEMPTY);
      C (ELOOP);
      C (ENOMSG);
      C (EIDRM);
      C (ECHRNG);
      C (EL2NSYNC);
      C (EL3HLT);
      C (EL3RST);
      C (ELNRNG);
      C (EUNATCH);
      C (ENOCSI);
      C (EL2HLT);
      C (EBADE);
      C (EBADR);
      C (EXFULL);
      C (ENOANO);
      C (EBADRQC);
      C (EBADSLT);
      C (EBFONT);
      C (ENOSTR);
      C (ENODATA);
      C (ETIME);
      C (ENOSR);
      C (ENONET);
      C (ENOPKG);
      C (EREMOTE);
      C (ENOLINK);
      C (EADV);
      C (ESRMNT);
      C (ECOMM);
      C (EPROTO);
      C (EMULTIHOP);
      C (EDOTDOT);
      C (EBADMSG);
      C (EOVERFLOW);
      C (ENOTUNIQ);
      C (EBADFD);
      C (EREMCHG);
      C (ELIBACC);
      C (ELIBBAD);
      C (ELIBSCN);
      C (ELIBMAX);
      C (ELIBEXEC);
      C (EILSEQ);
      C (ERESTART);
      C (ESTRPIPE);
      C (EUSERS);
      C (ENOTSOCK);
      C (EDESTADDRREQ);
      C (EMSGSIZE);
      C (EPROTOTYPE);
      C (ENOPROTOOPT);
      C (EPROTONOSUPPORT);
      C (ESOCKTNOSUPPORT);
      C (EOPNOTSUPP);
      C (EPFNOSUPPORT);
      C (EAFNOSUPPORT);
      C (EADDRINUSE);
      C (EADDRNOTAVAIL);
      C (ENETDOWN);
      C (ENETUNREACH);
      C (ENETRESET);
      C (ECONNABORTED);
      C (ECONNRESET);
      C (ENOBUFS);
      C (EISCONN);
      C (ENOTCONN);
      C (ESHUTDOWN);
      C (ETOOMANYREFS);
      C (ETIMEDOUT);
      C (ECONNREFUSED);
      C (EHOSTDOWN);
      C (EHOSTUNREACH);
      C (EALREADY);
      C (EINPROGRESS);
      C (ESTALE);
      C (EUCLEAN);
      C (ENOTNAM);
      C (ENAVAIL);
      C (EISNAM);
      C (EREMOTEIO);
      C (EDQUOT);
      C (ENOMEDIUM);
      C (EMEDIUMTYPE);
      C (ECANCELED);
      C (ENOKEY);
      C (EKEYEXPIRED);
      C (EKEYREVOKED);
      C (EKEYREJECTED);
      C (EOWNERDEAD);
      C (ENOTRECOVERABLE);
    default: return 0;
    }
#undef C
}

static int
errconstant_to_num (const char* what)
{
#define C(S) if (strcasecmp (what, #S) == 0) return S
  C (EPERM);
  C (ENOENT);
  C (ESRCH);
  C (EINTR);
  C (EIO);
  C (ENXIO);
  C (E2BIG);
  C (ENOEXEC);
  C (EBADF);
  C (ECHILD);
  C (EAGAIN);
  C (EWOULDBLOCK);
  C (ENOMEM);
  C (EACCES);
  C (EFAULT);
  C (ENOTBLK);
  C (EBUSY);
  C (EEXIST);
  C (EXDEV);
  C (ENODEV);
  C (ENOTDIR);
  C (EISDIR);
  C (EINVAL);
  C (ENFILE);
  C (EMFILE);
  C (ENOTTY);
  C (ETXTBSY);
  C (EFBIG);
  C (ENOSPC);
  C (ESPIPE);
  C (EROFS);
  C (EMLINK);
  C (EPIPE);
  C (EDOM);
  C (ERANGE);
  C (EDEADLK);
  C (EDEADLOCK);
  C (ENAMETOOLONG);
  C (ENOLCK);
  C (ENOSYS);
  C (ENOTEMPTY);
  C (ELOOP);
  C (ENOMSG);
  C (EIDRM);
  C (ECHRNG);
  C (EL2NSYNC);
  C (EL3HLT);
  C (EL3RST);
  C (ELNRNG);
  C (EUNATCH);
  C (ENOCSI);
  C (EL2HLT);
  C (EBADE);
  C (EBADR);
  C (EXFULL);
  C (ENOANO);
  C (EBADRQC);
  C (EBADSLT);
  C (EBFONT);
  C (ENOSTR);
  C (ENODATA);
  C (ETIME);
  C (ENOSR);
  C (ENONET);
  C (ENOPKG);
  C (EREMOTE);
  C (ENOLINK);
  C (EADV);
  C (ESRMNT);
  C (ECOMM);
  C (EPROTO);
  C (EMULTIHOP);
  C (EDOTDOT);
  C (EBADMSG);
  C (EOVERFLOW);
  C (ENOTUNIQ);
  C (EBADFD);
  C (EREMCHG);
  C (ELIBACC);
  C (ELIBBAD);
  C (ELIBSCN);
  C (ELIBMAX);
  C (ELIBEXEC);
  C (EILSEQ);
  C (ERESTART);
  C (ESTRPIPE);
  C (EUSERS);
  C (ENOTSOCK);
  C (EDESTADDRREQ);
  C (EMSGSIZE);
  C (EPROTOTYPE);
  C (ENOPROTOOPT);
  C (EPROTONOSUPPORT);
  C (ESOCKTNOSUPPORT);
  C (EOPNOTSUPP);
  C (EPFNOSUPPORT);
  C (EAFNOSUPPORT);
  C (EADDRINUSE);
  C (EADDRNOTAVAIL);
  C (ENETDOWN);
  C (ENETUNREACH);
  C (ENETRESET);
  C (ECONNABORTED);
  C (ECONNRESET);
  C (ENOBUFS);
  C (EISCONN);
  C (ENOTCONN);
  C (ESHUTDOWN);
  C (ETOOMANYREFS);
  C (ETIMEDOUT);
  C (ECONNREFUSED);
  C (EHOSTDOWN);
  C (EHOSTUNREACH);
  C (EALREADY);
  C (EINPROGRESS);
  C (ESTALE);
  C (EUCLEAN);
  C (ENOTNAM);
  C (ENAVAIL);
  C (EISNAM);
  C (EREMOTEIO);
  C (EDQUOT);
  C (ENOMEDIUM);
  C (EMEDIUMTYPE);
  C (ECANCELED);
  C (ENOKEY);
  C (EKEYEXPIRED);
  C (EKEYREVOKED);
  C (EKEYREJECTED);
  C (EOWNERDEAD);
  C (ENOTRECOVERABLE);
#undef C
  return -1;
}
