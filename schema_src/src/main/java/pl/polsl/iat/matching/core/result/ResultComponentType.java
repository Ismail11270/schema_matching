package pl.polsl.iat.matching.core.result;

import javax.xml.bind.annotation.adapters.XmlAdapter;
import java.util.Objects;

public enum ResultComponentType {
    SCHEMA, TABLE, COLUMN;
    public static class XmlTypeAdapter extends XmlAdapter<String, ResultComponentType> {

        @Override
        public ResultComponentType unmarshal(String s) throws Exception {
                return ResultComponentType.valueOf(s.toUpperCase());
        }

        @Override
        public String marshal(ResultComponentType resultComponentType) throws Exception {
            return Objects.requireNonNull(resultComponentType, "Result component type cannot be null").name().toLowerCase();
        }
    }
}