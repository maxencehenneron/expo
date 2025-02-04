import { DeviceType } from './Device.types';
declare const _default: {
    readonly isDevice: boolean;
    readonly brand: null;
    readonly manufacturer: null;
    readonly modelName: string | null;
    readonly deviceYearClass: null;
    readonly totalMemory: number | null;
    readonly supportedCpuArchitectures: string[] | null;
    readonly osName: string;
    readonly osVersion: string;
    readonly osBuildId: null;
    readonly osInternalBuildId: null;
    readonly deviceName: null;
    readonly deviceType: DeviceType;
    getDeviceTypeAsync(): Promise<DeviceType>;
    isRootedExperimentalAsync(): Promise<boolean>;
};
export default _default;
//# sourceMappingURL=ExpoDevice.web.d.ts.map