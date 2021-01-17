import { AuthService } from '@auth/service'

const auth_service = new AuthService();

auth_service.init();

auth_service.run();
