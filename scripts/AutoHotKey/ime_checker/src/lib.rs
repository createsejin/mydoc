use winapi::shared::minwindef::LRESULT;
use winapi::shared::windef::HWND;
use winapi::um::imm::ImmGetDefaultIMEWnd;
use winapi::um::winuser::{GetForegroundWindow, SendMessageW};

// IME 제어를 위한 Windows 메시지 및 서브커맨드 상수 정의
const WM_IME_CONTROL: u32 = 0x0283;
const IMC_GETOPENSTATUS: usize = 0x0005;

#[unsafe(no_mangle)]
pub extern "C" fn get_ime_mode() -> i32 {
    unsafe {
        // 1. 현재 활성화된 창의 핸들(HWND)을 가져옵니다.
        let hwnd: HWND = GetForegroundWindow();
        if hwnd.is_null() {
            return -1; // 활성 창 없음
        }

        // 2. 해당 창에 연결된 기본 IME 창의 핸들을 가져옵니다.
        //    메시지를 보낼 대상은 메인 창이 아니라 이 IME 창입니다.
        let ime_hwnd: HWND = ImmGetDefaultIMEWnd(hwnd);
        if ime_hwnd.is_null() {
            return -2; // 이 창은 IME를 사용하지 않음
        }

        // 3. IME 창에 "현재 변환 모드가 열려있는지(한글 상태인지)"를 묻는
        //    메시지를 보내고, 그 결과를 받습니다.
        let result: LRESULT = SendMessageW(
            ime_hwnd,
            WM_IME_CONTROL,
            IMC_GETOPENSTATUS,
            0,
        );

        // 4. 결과를 i32 타입으로 변환하여 반환합니다.
        //    (한글 모드일 때 1, 영문 모드일 때 0을 반환)
        result as i32
    }
}