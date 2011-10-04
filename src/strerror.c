#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>

static const char* errconstant (int errnum);

int
main (int argc, char** argv)
{
  int errnum;
  const char* constant;
  if (argc != 2
      || strcmp (argv[1], "-h") == 0
      || strcmp (argv[1], "--help") == 0)
    {
      fprintf (stderr, "usage: %s ERRNUM\n", argv[0]);
      return 1;
    }
  errnum = atoi (argv[1]);
  printf ("%s\n", strerror (errnum));
  if ((constant = errconstant (errnum)))
    printf ("%s\n", constant);
  return 0;
}

static const char*
errconstant (int errnum)
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
