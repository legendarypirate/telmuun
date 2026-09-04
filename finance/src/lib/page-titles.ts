const PAGE_TITLES: Record<string, string> = {
  "/": "Нэвтрэх",
  "/admin": "Хянах самбар",
  "/admin/delivery": "Хүргэлт",
  "/admin/order": "Татан авалт",
  "/admin/region": "Бүс",
  "/admin/notification": "Масс мэдэгдэл",
  "/admin/good": "Барааны жагсаалт",
  "/admin/request": "Барааны хүсэлт",
  "/admin/good-request": "Барааны хүсэлт",
  "/admin/report": "Тайлан",
  "/admin/report/product": "Барааны тайлан",
  "/admin/report/driver": "Жолоочийн тайлан",
  "/admin/log": "Үйлдлийн лог",
  "/admin/user": "Харилцагчийн жагсаалт",
  "/admin/user-driver": "Жолооч",
  "/admin/status": "Хүргэлтийн төлөвүүд",
  "/admin/role": "Эрхийн зохицуулалт",
  "/admin/warehouse": "Агуулах бүртгэх",
};

const APP_NAME = "Telmuun Delivery";

export function getPageTitle(pathname: string): string {
  const pageTitle = PAGE_TITLES[pathname];
  if (pageTitle) return `${pageTitle} | ${APP_NAME}`;
  return APP_NAME;
}

export { APP_NAME, PAGE_TITLES };
